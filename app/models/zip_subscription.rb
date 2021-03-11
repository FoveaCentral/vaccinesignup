# frozen_string_literal: true

class ZipSubscription < ApplicationRecord
  validates_uniqueness_of :user_id, :zip
end
