# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
namespace :vaccinesignup do
  desc 'Notify users about new appointments in their zip code.'
  task notify_users: :environment do
    results = Notifier.call
    puts "Notified #{results[:users]} users about #{results[:clinics]} appointments."
    Rails.logger.info "
  Notified #{results[:users]} users about #{results[:clinics]} appointments.
  "
  end

  desc 'Read direct messages for zip codes that users follow.'
  task read_dms: :environment do
    results = DirectMessageReader.call
    puts "Users DMd #{results[:subscribed]} new zips and stopped #{results[:stopped]} zips."
    Rails.logger.info "
  Users DMd #{results[:subscribed]} new zips and stopped #{results[:stopped]} zips.
  "
  end

  desc 'Sync Locations with LA County data.'
  task sync_locations: :environment do
    results = LocationSyncer.call
    puts "Parsed #{results[:total]} locations.",
         "Created #{results[:new]} locations.",
         "Updated #{results[:updated]} locations."
    Rails.logger.info "
  Parsed #{results[:total]} locations.
  Created #{results[:new]} locations.
  Updated #{results[:updated]} locations.
  "
  end

  desc 'Sync Locations, read DMs, and notify users.'
  task :sync_read_notify do
    puts 'Syncing Locations...'
    Rake::Task['vaccinesignup:sync_locations'].invoke
    puts nil, 'Reading DMs...'
    Rake::Task['vaccinesignup:read_dms'].invoke
    puts nil, 'Notifying users...'
    Rake::Task['vaccinesignup:notify_users'].invoke
  end
end
# rubocop:enable Metrics/BlockLength
