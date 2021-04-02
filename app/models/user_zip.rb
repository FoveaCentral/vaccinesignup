# frozen_string_literal: true

# Logs which users are subscribed to which zip codes.
class UserZip < ApplicationRecord
  validates_uniqueness_of :user_id, scope: :zip
end
