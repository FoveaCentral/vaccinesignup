# frozen_string_literal: true

namespace :vaccinesignup do
  desc 'Sync Locations.'
  task sync_locations: :environment do
    results = LocationSyncer.call
    puts "Parsed #{results[:total]}, created #{results[:new]}, updated #{results[:updated]} Locations."
  end
end
