# Copyright the @vaccinesignup contributors.
# SPDX-License-Identifier: CC0-1.0
# frozen_string_literal: true

require 'net/http'

# DM users about new Locations.
class NotifyBot < ApplicationService
  # Calls Notifier.call.
  #
  # @return [Notifier.call]
  def call
    Notifier.call if DirectMessageReader.call[:subscribed].positive?
  end
end
