# frozen_string_literal: true

# Reads direct messages for zips that users want to follow.
class DirectMessageReader < ApplicationService
  def initialize(dms = TWITTER_CLIENT.direct_messages_received.reverse)
    super()
    @direct_messages = dms
  end

  def call
    results = { stopped: 0, subscribed: 0 }
    @direct_messages.each do |dm|
      next if ReadDirectMessage.exists?(direct_message_id: dm.id)

      read(direct_message: dm, results: results)
    end
    results
  end

  private

  def create_zips_from_dm(direct_message:, results:)
    direct_message.text.scan(/\d{5}(?:[-\s]\d{4})?/).each do |zip|
      next if UserZip.exists?(user_id: direct_message.sender_id, zip: zip)

      UserZip.create(user_id: direct_message.sender_id, zip: zip) && results[:subscribed] += 1
      Rails.logger.info "#{direct_message.sender_id} subscribed to #{direct_message.text}."
    end
  end

  def read(direct_message:, results:)
    if direct_message.text.downcase == 'stop'
      results[:stopped] += UserZip.where(user_id: direct_message.sender_id).delete_all
      Rails.logger.info "#{direct_message.sender_id} stopped subscribing."
    else
      create_zips_from_dm(direct_message: direct_message, results: results)
    end
    ReadDirectMessage.create(direct_message_id: direct_message.id)
  end
end
