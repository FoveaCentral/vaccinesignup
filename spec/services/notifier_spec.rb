# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
describe Notifier do
  describe '#new' do
    Notifier.new
    it { expect(false).to be true }
  end
end