# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Parse direct messages for zip codes.
  def parse_direct_messages
    stopped = 0
    subscribed = 0
    TWITTER_CLIENT.direct_messages_received.each do |dm|
      next if ProcessedDirectMessage.exists?(direct_message_id: dm[:id])
      if !(dm[:text] =~ /[0-9]{5}/).nil?
        ZipSubscription.create(user_id: dm[:sender_id], zip: dm[:text])
        subscribed += 1
      elsif dm[:text].downcase == 'stop'
        ZipSubscription.delete(user_id: dm[:sender_id])
        stopped += 1
      end
      ProcessedDirectMessage.create(direct_message_id: dm[:id])
    end
    render plain: "Users DMd #{subscribed} new zips and stopped #{stopped} zips."
  end

  # Notify users of appointments in their zip code.
  def notify_users
    appointments = 0
    users = 0
    ZipSubscription.find_each do |zip_sub|
      clinics = Location.where('addr2 LIKE ?', "%#{zip_sub.zip}%")
      message = ['Appointments now available at:', nil]
      clinics.each do |clinic|
        message << "#{clinic.name} (#{clinic.addr1}, #{clinic.addr2}). Check eligibility and sign-up at #{clinic.link}"
        message << nil
        appointments += 1
      end

      TWITTER_CLIENT.create_direct_message(zip_sub.user_id, message * "\n")
      users += 1
    end
    render plain: "Notified #{users} users about #{appointments} appointments."
  end
end
