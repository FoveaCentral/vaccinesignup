# frozen_string_literal: true

TEST_USER_ID = 167_894_675
# rubocop:disable Metrics/BlockLength
namespace :vaccinesignup do
  desc 'Back-up production data and restore to the local environment.'
  task back_up: :environment do
    sh 'rm -f latest.dump'
    sh 'heroku pg:backups:capture'
    sh 'heroku pg:backups:download'
    sh 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -d vaccine_notifier latest.dump'
  end

  desc 'Delete real (non-test) users from development environment.'
  task delete_real_users: :environment do
    raise "Can't run this task on production!" unless Rails.env.development?

    puts "Deleted #{UserZip.where('user_id != ?', TEST_USER_ID).delete_all} non-test users."
  end

  desc 'Back-up production, restore locally, and delete real users for testing.'
  task reset_staging: :environment do
    Rake::Task['vaccinesignup:back_up'].invoke
    Rake::Task['vaccinesignup:delete_real_users'].invoke
  end

  desc 'Sync Locations and, if there are changes, notify users.'
  task sync_and_notify: :environment do
    results = SyncAndNotifyBot.call
    next unless Rails.env.development?

    if results[:total]
      if results[:zips].present?
        puts "Parsed #{results[:total]}, created #{results[:new]}, updated #{results[:updated]} Locations, which "\
             "affected these zips: #{results[:zips].to_a.to_sentence}."
      else
        puts "Parsed #{results[:total]}, created #{results[:new]}, updated #{results[:updated]} Locations."
      end
    else
      log_notification_results(results)
    end
  end

  private

  def log_notification_results(results)
    puts "Notified #{results[:users]} users about #{results[:locations]} Locations."
  end
end
# rubocop:enable Metrics/BlockLength
