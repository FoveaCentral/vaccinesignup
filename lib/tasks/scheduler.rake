# frozen_string_literal: true

namespace :vaccinesignup do
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
    results = SyncBot.call
    if results
      puts "Notified #{results[:users]} users about #{results[:clinics]} appointments."
      Rails.logger.info "Notified #{results[:users]} users about #{results[:clinics]} appointments."
    end
  end
end
