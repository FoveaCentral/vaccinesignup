# frozen_string_literal: true

require 'net/http'

# Syncs vaccine Locations with LA County's data set.
class LocationSyncer < ApplicationService
  LA_URL = 'http://publichealth.lacounty.gov/acd/ncorona2019/js/pod-data.js'

  def initialize(locations = js_locations)
    super()
    @locations = locations
  end

  def call
    new = 0
    locations = @locations.each do |location_h|
      id = location_h.delete('id')
      location = Location.find_by_best_key(id, location_h['addr1']) || Location.new
      new += 1 if location.new_record?
      location.update(location_h)
    end.size
    { locations: locations, new_locations: new }
  end

  private

  def js_locations
    response = Net::HTTP.get(URI(LA_URL)).gsub('var unfiltered = ', '')
    JSON.parse(response)
  end
end
