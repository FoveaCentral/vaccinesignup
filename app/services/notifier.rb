# Notifies users about available appointments in the zips they follow.
class Notifier < ApplicationService
  def initialize
  end

  def call
    clinics = 0
    users = 0
    UserZip.find_each do |zip_sub|
      locations = Location.where('addr2 LIKE ?', "%#{zip_sub.zip}%")
      message = ['Appointments now available at:', nil]
      locations.each do |clinic|
        message << "#{clinic.name} (#{clinic.addr1}, #{clinic.addr2}). Check eligibility and sign-up at #{clinic.link}"
        message << nil
        clinics += 1
      end

      TWITTER_CLIENT.create_direct_message(zip_sub.user_id, message * "\n")
      users += 1
    end
    {clinics: clinics, users: users}
  end
end
