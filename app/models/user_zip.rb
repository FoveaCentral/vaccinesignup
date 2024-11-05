# frozen_string_literal: true

# Logs which users are subscribed to which zip codes.
class UserZip < ApplicationRecord
  # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :user_id, uniqueness: { scope: :zip }
  # rubocop:enable Rails/UniqueValidationWithoutIndex
end
