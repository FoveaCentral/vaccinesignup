# frozen_string_literal: true

class UserZip < ApplicationRecord
  validates_uniqueness_of :user_id, :zip
end
