# frozen_string_literal: true

require 'net/http'

# Tweet users about new appointments.
class SyncBot < ApplicationService
  # Syncs Locations by calling LocationSyncer.call. If any Locations were
  # created/updated, tweets the updates by calling NotifyBot.call. In either
  # case, returns results as a Hash.
  #
  # @return [Hash] results tallying new, updated, and total Locations
  # @example
  #   SyncBot.call
  #     => {
  #             :new => 3,
  #         :updated => 37,
  #           :total => 403
  #     }
  def call
    results = LocationSyncer.call
    return results unless (results[:new]).positive? || (results[:updated]).positive?

    NotifyBot.call
  end
end
