# frozen_string_literal: true

require 'net/http'

# DM users about new appointments.
class NotifyBot < ApplicationService
  def call
    Notifier.call if DirectMessageReader.call[:subscribed].positive?
  end
end
