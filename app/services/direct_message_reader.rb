# frozen_string_literal: true

# Reads direct messages for zips that users want to follow.
class DirectMessageReader < ApplicationService
  def initialize(dms = TWITTER_CLIENT.direct_messages_received.reverse)
    super()
    @direct_messages = dms
  end

  def call
    stopped = 0
    subscribed = 0
    @direct_messages.each do |dm|
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
      if sub.persisted?
        subscribed += 1
        Rails.logger.info "#{direct_message.sender_id} subscribed to #{direct_message.text}"
      end
    elsif direct_message.text.downcase == 'stop'
      stopped += UserZip.where(user_id: direct_message.sender_id).delete_all
      Rails.logger.info "#{direct_message.sender_id} stopped subscribing"
    end
    ReadDirectMessage.create(direct_message_id: dm.id)
    { stopped: stopped, subscribed: subscribed }
  end
end
