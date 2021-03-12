# frozen_string_literal: true

# Controller for managing Covid-19 vaccine Locations.
class LocationsController < ApplicationController
  # Syncs vaccine Locations with LA County's data set.
  def sync
    results = LocationSyncer.call
    render plain: ["Parsed #{results[:total]} locations.",
                   "Created #{results[:new]} locations.",
                   "Updated #{results[:updated]} locations."].join("\n")
  end
end
