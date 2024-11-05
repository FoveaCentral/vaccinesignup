# Copyright the @vaccinesignup contributors.
# SPDX-License-Identifier: CC0-1.0
# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
# rubocop:disable Metrics/BlockLength
describe Notifier do
  describe '#call' do
    subject { described_class.call(user_zips) }

    before do
      allow(TWITTER_CLIENT).to receive(:create_direct_message)
      location
    end

    let(:location) { FactoryBot.create(:location) }

    context 'when a user subscribes to a matching Location' do
      let(:user_zips) { [UserZip.new(user_id: 1, zip: '90210')] }

      it { is_expected.to include({ locations: 1, users: 1 }) }

      describe 'Rails.logger' do
        context 'when Twitter errors out' do
          before { allow(TWITTER_CLIENT).to receive(:create_direct_message).and_raise(Twitter::Error) }

          after { described_class.call(user_zips) }

          it { expect(Rails.logger).to receive(:error).once }
        end
      end

      describe 'TWITTER_CLIENT' do
        subject { TWITTER_CLIENT }

        after { described_class.call(user_zips) }

        it { is_expected.to receive(:create_direct_message) }
      end

      context 'when a user subscribes to a second matching Location in another zip code' do
        before { FactoryBot.create(:location, '90044') }

        let(:user_zips) { [UserZip.new(user_id: 1, zip: '90210'), UserZip.new(user_id: 1, zip: '90044')] }

        describe 'TWITTER_CLIENT' do
          subject { TWITTER_CLIENT }

          after { described_class.call(user_zips) }

          it { is_expected.to receive(:create_direct_message).twice }
        end
      end
    end

    context 'when a user subscribes to a non-existing Location' do
      let(:user_zips) { [UserZip.new(user_id: 1, zip: '90044')] }

      it { is_expected.to include({ locations: 0, users: 0 }) }

      describe 'TWITTER_CLIENT' do
        subject { TWITTER_CLIENT }

        after { described_class.call(user_zips) }

        it { is_expected.not_to receive(:create_direct_message) }
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
