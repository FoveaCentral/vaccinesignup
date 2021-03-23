# frozen_string_literal: true

# Represents a vaccine location.
class Location < ApplicationRecord
  alias_attribute :xParent, :x_parent
  alias_attribute :NumChildren, :num_children
  alias_attribute :mapZoom, :map_zoom
  alias_attribute :notesSpn, :notes_spn
  alias_attribute :altSpn, :alt_spn
  alias_attribute :secondDose, :second_dose
  alias_attribute :commentsSpn, :comments_spn
  alias_attribute :clinicFormat, :clinic_format

  # Finds the Location matching the specified ID or street address.
  #
  # @param la_id [String] the Location's ID from LA County
  # @param address1 [String] the Location's street address line 1
  # @return [Location] the matching Location
  # @example
  #   Location.find_by_best_key(la_id: '1', address1: '1261 W 79th Street')
  def self.find_by_best_key(la_id:, address1:)
    if la_id.present?
      Location.where('la_id = ?', la_id.to_s)
    elsif address1.present?
      Location.where('addr1 = ?', address1.to_s)
    else
      Location.none
    end.first
  end

  # Finds or initializes the Location with the specified attributes.
  #
  # @param attr [Hash] the attributes for the Location
  # @return [Location] the found or initialized Location
  # @example
  #   Location.find_or_init({ la_id: '1', address1: '1261 W 79th Street' })
  def self.find_or_init(attr)
    la_id = attr.delete('id')
    location = find_by_best_key(la_id: la_id, address1: attr['addr1']) || Location.new(la_id: la_id)
    location.attributes = attr
    location
  end

  # Returns the Location's zip code.
  #
  # @return [String] the zip code
  def zip
    @zip ||= addr2.scan(/\d{5}(?:[-\s]\d{4})?/).first
  end
end
