# frozen_string_literal: true

# Notifies users about available appointments in the zips they follow.
class Notifier < ApplicationService
  def initialize(user_zips = UserZip.find_each)
    super()
    @user_zips = user_zips
  end

  def call
    results = parse_user_zips(clinics: 0, users: 0)
    { clinics: results[:clinics], users: results[:users] }
  end

  private

  def parse_matching_locations(clinics:, message:, user_zip:)
    Location.where('addr2 LIKE ?', "%#{user_zip.zip}%").each do |clinic|
      message << "#{clinic.name} (#{clinic.addr1}, #{clinic.addr2}). Check eligibility and sign-up at #{clinic.link}"
      message << nil
      clinics += 1
    end
  end

  def parse_user_zips(clinics:, users:)
    @user_zips.each do |user_zip|
      parse_matching_locations(clinics: clinics, message: ['Appointments now available at:', nil], user_zip: user_zip)
      TWITTER_CLIENT.create_direct_message(user_zip.user_id, message * "\n")
      users += 1
    end
    { clinics: clinics, users: users }
  end
end
