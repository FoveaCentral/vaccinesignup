# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength: Block has too many lines
namespace :vaccinesignup do
  desc 'Read DMs and, if there are subscribed zip codes, notify users.'
  task read_and_notify: :environment do
    results = NotifyBot.call
    if results
      puts "Notified #{results[:users]} users about #{results[:clinics]} appointments."
      Rails.logger.info "
      Notified #{results[:users]} users about #{results[:clinics]} appointments.
"
    else
      puts 'Got null results!'
      Rails.logger.error 'Got null results!'
    end
  end

  desc 'Sync Locations and, if there are changes, notify users.'
  task sync_and_notify: :environment do
    results = SyncBot.call
    if results
      puts "Notified #{results[:users]} users about #{results[:clinics]} appointments."
      Rails.logger.info "
    Notified #{results[:users]} users about #{results[:clinics]} appointments.
"
    else
      puts 'Got null results!'
      Rails.logger.error 'Got null results!'
    end
  end
end
# rubocop:enable Metrics/BlockLength: Block has too many lines
