# frozen_string_literal: true

# Superclass for all ActiveRecords.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
