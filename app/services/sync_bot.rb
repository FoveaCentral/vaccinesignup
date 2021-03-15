# frozen_string_literal: true

require 'net/http'

# Tweet users about new appointments.
class SyncBot < ApplicationService
  def call
    results = LocationSyncer.call
    return results unless (results[:new]).positive? || (results[:updated]).positive?

    NotifyBot.call
  end
end
