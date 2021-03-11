# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Parse direct messages for zip codes.
  def parse_direct_messages
    i = 0
    TWITTER_CLIENT.direct_messages_received.each do |dm|
      next unless !!(dm[:text] =~ /[0-9]{5}/) && !ProcessedDirectMessage.exists?(dm[:id])

      ZipSubscription.create(user_id: dm[:sender_id], zip: dm[:text])
      ProcessedDirectMessage.create(direct_message_id: dm[:id])
      i += 1
    end
    render plain: "Users DMd #{i} new zip codes."
  end

  # Notify users of appointments in their zip code.
  def notify_users
    appointments = 0
    i = 0
    ZipSubscription.find_each do |zip_sub|
      clinics = Location.where('addr2 LIKE ?', "%#{zip_sub.zip}%")
      message = ['Appointments now available at:', nil]
      clinics.each do |clinic|
        message << "#{clinic.name} (#{clinic.addr1}, #{clinic.addr2}). Check eligibility and sign-up at #{clinic.link}"
        message << nil
        appointments += 1
      end

      TWITTER_CLIENT.create_direct_message(zip_sub.user_id, message * "\n")
      i += 1
    end
    render plain: "Notified #{i} users about #{appointments} appointments."
  end
end
