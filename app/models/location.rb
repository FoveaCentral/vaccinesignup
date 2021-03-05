# frozen_string_literal: true

class Location < ApplicationRecord
  alias_attribute :xParent, :x_parent
  alias_attribute :NumChildren, :num_children
  alias_attribute :mapZoom, :map_zoom
  alias_attribute :notesSpn, :notes_spn
  alias_attribute :altSpn, :alt_spn
  alias_attribute :secondDose, :second_dose
  alias_attribute :commentsSpn, :comments_spn
  alias_attribute :clinicFormat, :clinic_format
end
