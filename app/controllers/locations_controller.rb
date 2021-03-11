# frozen_string_literal: true

# Controller for managing Covid-19 vaccine Locations.
class LocationsController < ApplicationController
  # Syncs vaccine Locations with LA County's data set.
  def sync
    results = LocationSyncer.call
    render plain: ["Parsed #{results[:locations]} locations.", "Created #{results[:new_locations]} locations."].join("\n")
  end
end
