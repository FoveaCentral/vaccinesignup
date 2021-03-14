# frozen_string_literal: true

require 'net/http'

# Tweet users about new appointments.
class SyncBot < ApplicationService
  def call
    sync_results = LocationSyncer.call
    return unless (sync_results[:new]).positive? || (sync_results[:updated]).positive?

    NotifyBot.call
  end
end
