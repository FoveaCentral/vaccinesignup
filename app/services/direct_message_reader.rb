# frozen_string_literal: true

# Reads direct messages for zips that users want to follow.
class DirectMessageReader < ApplicationService
  def call
    stopped = 0
    subscribed = 0
    TWITTER_CLIENT.direct_messages_received.reverse.each do |dm|
      next if ReadDirectMessage.exists?(direct_message_id: dm.id)

      h = parse(direct_message: dm, stopped: stopped, subscribed: subscribed)
      stopped = h.stopped
      subscribed = h.subscribed
    end
    { stopped: stopped, subscribed: subscribed }
  end

  private

  def parse(direct_message:, stopped:, subscribed:)
    if !(direct_message.text =~ /^[0-9]{5}$/).nil?
      sub = UserZip.create_or_find_by(user_id: direct_message.sender_id, zip: direct_message.text)
      subscribed += 1 if sub.persisted?
    elsif direct_message.text.downcase == 'stop'
      stopped += UserZip.where(user_id: direct_message.sender_id).delete_all
    end
    ReadDirectMessage.create(direct_message_id: dm.id)
    { subscribed: subscribed, stopped: stopped }
  end
end
