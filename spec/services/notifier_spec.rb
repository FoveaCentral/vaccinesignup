# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
# rubocop:disable Metrics/BlockLength
describe Notifier do
  describe '#call' do
    subject { Notifier.call(user_zips) }

    before do
      allow(TWITTER_CLIENT).to receive(:create_direct_message)
      location
    end

    let(:location) { FactoryBot.create(:location) }
    let(:user_zips) { [UserZip.new(user_id: 1, zip: '90210')] }

    context 'when a user subscribes to a matching Location' do
      let(:user_zips) { [UserZip.new(user_id: 1, zip: '90210')] }

      it { should include({ clinics: 1, users: 1 }) }

      specify('message text') { expect(subject[:message]).to include Notifier::DM_FOOTER }

      context "when Location doesn't have a link" do
        describe 'message text' do
          let(:location) { FactoryBot.create(:location, :location_without_link) }

          specify { expect(subject[:message].join).not_to match(/sign-up at/i) }
        end
      end

      describe 'TWITTER_CLIENT' do
        subject { TWITTER_CLIENT }

        after { Notifier.call(user_zips) }

        it { is_expected.to receive(:create_direct_message) }
      end
    end
    context 'when a user subscribes to a non-existing Location' do
      let(:user_zips) { [UserZip.new(user_id: 1, zip: '90044')] }

      it { should include({ clinics: 0, users: 0 }) }

      describe 'TWITTER_CLIENT' do
        subject { TWITTER_CLIENT }

        after { Notifier.call(user_zips) }

        it { is_expected.not_to receive(:create_direct_message) }
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
