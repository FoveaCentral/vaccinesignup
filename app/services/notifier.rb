# frozen_string_literal: true

# Notifies users about available appointments in the zips they follow.
class Notifier < ApplicationService
  DM_HEADER = ['Appointments now available at:', nil].freeze
  DM_FOOTER = "We'll send you available appointments as soon as we're aware. DM 'stop' to cease notifications."

  def initialize(user_zips = UserZip.find_each)
    super()
    @user_zips = user_zips
  end

  def call
    results = { clinics: 0, users: 0 }
    @user_zips.each do |user_zip|
      results[:user_zip] = user_zip
      next unless message_for_matching_locations(results)

      dm_results(results)
    end
    { clinics: results[:clinics], message: results[:message], users: results[:users] }
  end

  private

  def clinic_link(clinic)
    output = ["#{clinic.name} (#{clinic.addr1}, #{clinic.addr2})."]
    output << "Check eligibility and sign-up at #{clinic.link}" if clinic.link
    output * "\n"
  end

  def dm_results(results)
    TWITTER_CLIENT.create_direct_message(results[:user_zip].user_id, results[:message] * "\n")
    results[:users] += 1
    Rails.logger.info "Found #{results[:clinics]} clinics for #{results[:user_zip].zip}."
  end

  # rubocop:disable Metrics/AbcSize
  def message_for_matching_locations(results)
    Location.where('addr2 LIKE ?', "%#{results[:user_zip].zip}%").find_each do |clinic|
      results[:message] ||= DM_HEADER.dup
      results[:message] << clinic_link(clinic)
      results[:message] << nil
      results[:clinics] += 1
    end
    results[:message] << DM_FOOTER if results[:message]
  end
  # rubocop:enable Metrics/AbcSize
end
