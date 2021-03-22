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
  # @param id [String] the Location's ID
  # @param address1 [String] the Location's street address line 1
  # @return [Location] the matching Location
  # @example
  #   Location.find_by_best_key('1', '1261 W 79th Street')
  def self.find_by_best_key(id, address1)
    Location.where('id = ? OR addr1 = ?', id.to_i, address1).limit(1).find_each.first
  end
end
