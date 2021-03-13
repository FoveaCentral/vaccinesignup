# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
describe Notifier do
  before(:all) { FactoryBot.create(:location) }

  let(:user_zips) { [UserZip.new(user_id: 1, zip: '90210')] }

  subject { Notifier.new(user_zips) }

  describe '#call' do
    before { allow(TWITTER_CLIENT).to receive(:create_direct_message) }

    let(:results) { subject.call }

    it { expect(results).to eq({ clinics: 1, users: 1 }) }
  end
end
