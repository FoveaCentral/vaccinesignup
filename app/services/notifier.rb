# frozen_string_literal: true

# Notifies users about available appointments in the zips they follow.
class Notifier < ApplicationService
  DM_HEADER = ['Appointments now available at:', nil].freeze
  DM_FOOTER = "We'll send you available appointments as soon as we're aware. DM 'stop' to cease notifications."

  # Creates a Notifier, setting @user_zips to the specified array of UserZips.
  # Defaults to all existing UserZips.
  #
  # @param user_zips [Array] UserZips
  # @return [Notifier]
  # @example
  #   Notifier.new
  def initialize(user_zips = UserZip.find_each)
    super()
    @user_zips = user_zips
  end

  # DMs users about Locations in zip codes they follow.
  #
  # @return [Hash] the message and number of locations and users DMd
  # @example
  #   Notifier.call
  #     => {
  #         :locations => 10,
  #         :message => ["Appointments now available at:", ...]
  #           :users => 18
  #     }
  def call
    results = { locations: 0, users: 0 }
    @user_zips.each do |user_zip|
      results[:user_zip] = user_zip
      next unless message_for_matching_locations(results)

      results[:message] << DM_FOOTER
      dm_results(results)
      results[:message] = nil
    end
    Rails.logger.info "Notified #{results[:users]} users about #{results[:locations]} appointments."
    { locations: results[:locations], users: results[:users] }
  end

  private

  def clinic_link(location)
    output = ["#{location.name} (#{location.addr1}, #{location.addr2})."]
    output << "Check eligibility and sign-up at #{location.link}" if location.link
    output * "\n"
  end

  # rubocop:disable Metrics/AbcSize
  def dm_results(results)
    begin
      TWITTER_CLIENT.create_direct_message(results[:user_zip].user_id, results[:message] * "\n")
      results[:users] += 1
    rescue Twitter::Error => e
      Rails.logger.error %(
#{e.class} when DMing user_id #{results[:user_zip].user_id} with...\n#{results[:message] * "\n"}!
)
    end
    Rails.logger.info "DMd user #{results[:user_zip].user_id} #{results[:locations]} locations for "\
                      "#{results[:user_zip].zip}."
  end
  # rubocop:enable Metrics/AbcSize

  def message_for_matching_locations(results)
    Location.where('addr2 LIKE ?', "%#{results[:user_zip].zip}%").find_each do |location|
      results[:message] ||= DM_HEADER.dup
      results[:message] << clinic_link(location)
      results[:message] << nil
      results[:locations] += 1
    end
    results[:message]
  end
end
