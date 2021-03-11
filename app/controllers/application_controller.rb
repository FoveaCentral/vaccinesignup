# frozen_string_literal: true

# Superclass for all controllers.
class ApplicationController < ActionController::Base
  # Parse direct messages for zip codes.
  def read_direct_messages
    stopped = 0
    subscribed = 0
    TWITTER_CLIENT.direct_messages_received.reverse.each do |dm|
      next if ReadDirectMessage.exists?(direct_message_id: dm[:id])

      if !!(dm[:text] =~ /^[0-9]{5}$/)
        sub = UserZip.create_or_find_by(user_id: dm[:sender_id], zip: dm[:text])
        subscribed += 1 if sub.persisted?
      elsif dm[:text].downcase == 'stop'
        stopped += UserZip.where(user_id: dm[:sender_id]).delete_all
      end
      ReadDirectMessage.create(direct_message_id: dm[:id])
    end
    render plain: "Users DMd #{subscribed} new zips and stopped #{stopped} zips."
  end

  # Notify users of appointments in their zip code.
  def notify_users
    results = Notifier.call
    render plain: "Notified #{results[:users]} users about #{results[:clinics]} appointments."
  end
end
