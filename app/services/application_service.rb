# frozen_string_literal: true

# Superclass for all services.
class ApplicationService
  def self.call(...)
    new(...).call
  end
end
