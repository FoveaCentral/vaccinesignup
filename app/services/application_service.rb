# frozen_string_literal: true

# Superclass for all services.
class ApplicationService
  # Creates and calls the ApplicationService subclass.
  #
  # @return [ApplicationService.new.call]
  def self.call(...)
    new(...).call
  end
end
