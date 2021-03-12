# frozen_string_literal: true

# Reads direct messages for zips that users want to follow.
class DirectMessageReader < ApplicationService
  def call
    stopped = 0
    subscribed = 0
    TWITTER_CLIENT.direct_messages_received.reverse.each do |dm|
      next if ReadDirectMessage.exists?(direct_message_id: dm.id)

      if !(dm.text =~ /^[0-9]{5}$/).nil?
        sub = UserZip.create_or_find_by(user_id: dm.sender_id, zip: dm.text)
        subscribed += 1 if sub.persisted?
      elsif dm.text.downcase == 'stop'
        stopped += UserZip.where(user_id: dm.sender_id).delete_all
      end
      ReadDirectMessage.create(direct_message_id: dm.id)
    end
    { stopped: stopped, subscribed: subscribed }
  end
end
