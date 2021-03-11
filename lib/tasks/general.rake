# frozen_string_literal: true

desc 'Notify users about new appointments in their zip code.'
task notify_users: :environment do
  results = Notifier.call
  puts "Notified #{results[:users]} users about #{results[:clinics]} appointments."
  Rails.logger.info ''"
Notified #{results[:users]} users about #{results[:clinics]} appointments.
"''
end

desc 'Read direct messages for zip codes.'
task read_dms: :environment do
  results = DirectMessageReader.call
  puts "Users DMd #{results[:subscribed]} new zips and stopped #{results[:stopped]} zips."
  Rails.logger.info ''"
Users DMd #{results[:subscribed]} new zips and stopped #{results[:stopped]} zips.
"''
end

desc 'Sync Locations with LA County data.'
task sync_locations: :environment do
  results = LocationSyncer.call
  puts "Parsed #{results[:locations]} locations.",
       "Created #{results[:new_locations]} locations."
  Rails.logger.info ''"
Parsed #{results[:locations]} locations.
Created #{results[:new_locations]} locations.
"''
end
