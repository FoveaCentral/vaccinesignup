# frozen_string_literal: true

# Controller for managing Covid-19 vaccine Locations.
class LocationsController < ApplicationController
  require 'net/http'

  LA_URL = 'http://publichealth.lacounty.gov/acd/ncorona2019/js/pod-data.js'

  # Syncs vaccine Locations with LA County's data set.
  def sync
    new = 0
    location_a = la_locations
    location_a.each do |location_h|
      id = location_h.delete('id')
      location = Location.find_by_best_key(id, location_h['addr1']) || Location.new
      new += 1 if location.new_record?
      location.update(location_h)
    end
    render plain: ["Parsed #{location_a.size} locations.", "Created #{new} locations."].join("\n")
  end

  private

  def la_locations
    response = Net::HTTP.get(URI(LA_URL)).gsub('var unfiltered = ', '')
    JSON.parse(response)
  end
end
