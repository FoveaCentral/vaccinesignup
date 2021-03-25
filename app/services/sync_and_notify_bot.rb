# frozen_string_literal: true

require 'net/http'

# Sync Locations and DM users about new appointment-locations.
class SyncAndNotifyBot < ApplicationService
  # Syncs Locations by calling LocationSyncer.call. If any Locations were
  # created/updated, DMs the updates by calling Notifier.call. In either case,
  # returns results as a Hash.
  #
  # @return [Hash] LocationSyncer or Notifier results
  # @example
  #   SyncAndNotifyBot.call
  #     => {
  #             :new => 388,
  #         :updated => 0,
  #            :zips => [
  #                       "90044",
  #                       "91340",
  #                       ...
  #                     ],
  #           :total => 405
  #     }
  def call
    results = LocationSyncer.call
    return results unless results[:zips]&.size&.positive?

    Notifier.call(UserZip.where(zip: results[:zips]))
  end
end
