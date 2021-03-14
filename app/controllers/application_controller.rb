# frozen_string_literal: true

# Superclass for all controllers.
class ApplicationController < ActionController::Base
  # Read direct messages for users that have subscribed to zip codes.
  def read_dms
    results = DirectMessageReader.call
    render plain: "Users DMd #{results[:subscribed]} new zips and stopped #{results[:stopped]} zips."
  end

  # Notify users of appointments in their zip code.
  def notify_users
    results = Notifier.call
    render plain: "Notified #{results[:users]} users about #{results[:clinics]} appointments."
  end

  # Syncs vaccine Locations with LA County's data set.
  def sync_locations
    results = LocationSyncer.call
    render plain: ["Parsed #{results[:total]} locations.",
                   "Created #{results[:new]} locations.",
                   "Updated #{results[:updated]} locations."].join("\n")
  end
end
