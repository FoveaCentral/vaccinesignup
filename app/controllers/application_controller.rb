# frozen_string_literal: true

# Superclass for all controllers.
class ApplicationController < ActionController::Base
  # Parse direct messages for zip codes.
  def read_direct_messages
    results = DirectMessageReader.call
    render plain: "Users DMd #{results[:subscribed]} new zips and stopped #{results[:stopped]} zips."
  end

  # Notify users of appointments in their zip code.
  def notify_users
    results = Notifier.call
    render plain: "Notified #{results[:users]} users about #{results[:clinics]} appointments."
  end
end
