# frozen_string_literal: true

require 'net/http'

# Tweet users about new appointments.
class NotifyBot < ApplicationService
  def call
    Notifier.call if DirectMessageReader.call[:subscribed].positive?
  end
end
