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

      results = read(direct_message: dm, results: results)
    end
    results
  end

  private

  def dm_is_a_zip_and_user_zip_saved?(direct_message)
    !(direct_message.text =~ /^[0-9]{5}$/).nil? && UserZip.create_or_find_by(user_id: direct_message.sender_id,
                                                                             zip: direct_message.text).persisted?
  end

  # rubocop:disable Metrics/AbcSize
  def read(direct_message:, results:)
    if dm_is_a_zip_and_user_zip_saved?(direct_message)
      results[:subscribed] += 1
      Rails.logger.info "#{direct_message.sender_id} subscribed to #{direct_message.text}."
    elsif direct_message.text.downcase == 'stop'
      results[:stopped] += UserZip.where(user_id: direct_message.sender_id).delete_all
      Rails.logger.info "#{direct_message.sender_id} stopped subscribing."
    end
    ReadDirectMessage.create(direct_message_id: direct_message.id)
    results
  end
  # rubocop:enable Metrics/AbcSize
end
