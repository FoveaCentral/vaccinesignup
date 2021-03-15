# frozen_string_literal: true

require 'net/http'

# Tweet users about new appointments.
class SyncBot < ApplicationService
  def call
    results = LocationSyncer.call
    output = ["Parsed #{results[:total]} locations.", "Created #{results[:new]} locations.",
              "Updated #{results[:updated]} locations."]
    Rails.logger.info output * "\n"
    return results unless (results[:new]).positive? || (results[:updated]).positive?

    NotifyBot.call
  end
end
