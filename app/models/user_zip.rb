# frozen_string_literal: true

# Logs which users are subscribed to which zip codes.
class UserZip < ApplicationRecord
  validates :user_id, uniqueness: { scope: :zip }
end
