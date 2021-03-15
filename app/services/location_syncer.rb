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
    results = { new: 0, updated: 0 }
    results[:total] = @locations.each do |attr|
      location = Location.find_by_best_key(attr.delete('id'), attr['addr1']) || Location.new
      location.attributes = attr
      (location.new_record? && results[:new] += 1) || (location.changed? && results[:updated] += 1)
      location.save
    end.size
    log_results(results)
    results
  end

  private

  def js_locations
    response = Net::HTTP.get(URI(LA_URL)).gsub('var unfiltered = ', '')
    JSON.parse(response).sort_by { |l| [l['id'].blank? ? 1 : 0, l['id'].to_i] } # sort blacnk IDs last
  end

  def log_results(results)
    Rails.logger.info "Parsed #{results[:total]}, created #{results[:new]}, updated #{results[:updated]} Locations."
  end
end
