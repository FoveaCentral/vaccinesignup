# Copyright the @vaccinesignup contributors.
# frozen_string_literal: true

require 'net/http'

# DM users about new Locations.
class NotifyBot < ApplicationService
  def call
    Notifier.call if DirectMessageReader.call[:subscribed].positive?
  end
end
