class LocationsController < ApplicationController
  require 'net/http'

  LA_URL = 'http://publichealth.lacounty.gov/acd/ncorona2019/js/pod-data.js'

  def sync
    response = Net::HTTP.get(URI(LA_URL)).gsub('var unfiltered = ', '')
    location_array = JSON.parse(response)
    location_array.each do |location_hash|
      id = location_hash.delete('id')
      location = Location.find_by(id: id) ||
        Location.find_by(addr1: location_hash['addr1']) ||
        Location.new
      location.update(location_hash)
    end
    render plain: "Synced #{location_array.size} locations."
  end
end
