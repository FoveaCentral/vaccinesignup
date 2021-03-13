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
    updated = 0
    total = @locations.each do |location_h|
      location = Location.find_by_best_key(location_h.delete('id'), location_h['addr1'])
      location = Location.new && new += 1 if location.nil?
      location.attributes = location_h
      updated += 1 if location.changed? && location.persisted?
      location.save
    end.size
    { total: total, new: new, updated: updated }
  end

  private

  def js_locations
    response = Net::HTTP.get(URI(LA_URL)).gsub('var unfiltered = ', '')
    JSON.parse(response)
  end
end
