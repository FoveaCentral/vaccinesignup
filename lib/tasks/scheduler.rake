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

  desc 'Sync Locations.'
  task sync_locations: :environment do
    results = LocationSyncer.call
    puts "Parsed #{results[:total]}, created #{results[:new]}, updated #{results[:updated]} Locations."
  end
end
