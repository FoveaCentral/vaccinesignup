# frozen_string_literal: true

require 'net/http'

# Syncs vaccine Locations with LA County's data set.
class LocationSyncer < ApplicationService
  LA_URL = 'http://publichealth.lacounty.gov/acd/ncorona2019/js/pod-data.js'

  # Creates a LocationSyncer, setting @locations to the specified array of
  # location attributes. Defaults to LA County's locations.
  #
  # @param locations [Array] array of location-attribute hashes
  # @return [LocationSyncer]
  # @example
  #   LocationSyncer.new
  def initialize(locations = js_locations)
    super()
    @locations = locations
  end

  # Creates or updates Locations based on the array of location-attribute
  # hashes @locations.
  #
  # @return [Hash] results tallying new, updated, and total Locations
  # @example
  #   LocationSyncer.call
  #     => {
  #             :new => 3,
  #         :updated => 37,
  #           :total => 403
  #     }
  def call
    results = { new: 0, updated: 0 }
    results[:total] = @locations.each do |attr|
      la_id = attr.delete('id')
      location = Location.find_by_best_key(la_id: la_id, address1: attr['addr1']) || Location.new(la_id: la_id)
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
