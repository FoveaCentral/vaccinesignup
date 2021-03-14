# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
describe Notifier do
  describe '#call' do
    subject { Notifier.call(user_zips) }

    before do
      allow(TWITTER_CLIENT).to receive(:create_direct_message)
      FactoryBot.create(:location)
    end

    let(:user_zips) { [UserZip.new(user_id: 1, zip: '90210')] }

    it { should eq({ clinics: 1, users: 1 }) }
  end
end
