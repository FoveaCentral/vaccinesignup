# frozen_string_literal: true

namespace :vaccinesignup do
  desc 'Back-up production data and restore to the local environment.'
  task back_up: :environment do
    sh 'heroku pg:backups:download'
    sh 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -d vaccine_notifier latest.dump'
  end

  desc 'Read DMs and, if there are subscribed zip codes, notify users.'
  task read_and_notify: :environment do
    results = NotifyBot.call
    if results
      puts "Notified #{results[:users]} users about #{results[:clinics]} appointments."
      Rails.logger.info "Notified #{results[:users]} users about #{results[:clinics]} appointments."
    end
  end

  desc 'Sync Locations and, if there are changes, notify users.'
  task sync_and_notify: :environment do
    results = SyncAndNotifyBot.call
    if results
      puts "Notified #{results[:users]} users about #{results[:clinics]} appointments."
      Rails.logger.info "Notified #{results[:users]} users about #{results[:clinics]} appointments."
    end
  end
end
