# frozen_string_literal: true

require 'net/http'

# Tweet users about new appointments.
class Bot < ApplicationService
  def call
    sync_results = LocationSyncer.call
    if (sync_results[:new]).positive? || (sync_results[:updated]).positive?
      read_results = DirectMessageReader.call
      results = Notifier.call if (read_results[:subscribed]).positive?
    end
  end
end
