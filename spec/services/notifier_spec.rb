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

    let(:location) { create(:location) }

    context 'when a user subscribes to a matching Location' do
      let(:user_zips) { [UserZip.new(user_id: 1, zip: '90210')] }

      it { is_expected.to include({ locations: 1, users: 1 }) }

      # rubocop:disable RSpec/NestedGroups
      describe 'Rails.logger' do
        context 'when Twitter errors out' do
          before do
            allow(TWITTER_CLIENT).to receive(:create_direct_message).and_raise(Twitter::Error)
            allow(Rails.logger).to receive(:error)
          end

          after { described_class.call(user_zips) }

          # rubocop:disable RSpec/MessageSpies
          it { expect(Rails.logger).to receive(:error).once }
          # rubocop:enable RSpec/MessageSpies
        end
      end

      describe 'TWITTER_CLIENT' do
        subject { TWITTER_CLIENT }

        after { described_class.call(user_zips) }

        # rubocop:disable RSpec/SubjectStub
        it { is_expected.to receive(:create_direct_message) }
        # rubocop:enable RSpec/SubjectStub
      end

      context 'when a user subscribes to a second matching Location in another zip code' do
        before { create(:location, '90044') }

        let(:user_zips) { [UserZip.new(user_id: 1, zip: '90210'), UserZip.new(user_id: 1, zip: '90044')] }

        describe 'TWITTER_CLIENT' do
          subject { TWITTER_CLIENT }

          after { described_class.call(user_zips) }

          # rubocop:disable RSpec/SubjectStub
          it { is_expected.to receive(:create_direct_message).twice }
          # rubocop:enable RSpec/SubjectStub
        end
      end
      # rubocop:enable RSpec/NestedGroups
    end

    context 'when a user subscribes to a non-existing Location' do
      let(:user_zips) { [UserZip.new(user_id: 1, zip: '90044')] }

      it { is_expected.to include({ locations: 0, users: 0 }) }

      # rubocop:disable RSpec/NestedGroups
      describe 'TWITTER_CLIENT' do
        subject { TWITTER_CLIENT }

        after { described_class.call(user_zips) }

        # rubocop:disable RSpec/SubjectStub
        it { is_expected.not_to receive(:create_direct_message) }
        # rubocop:enable RSpec/SubjectStub
      end
      # rubocop:enable RSpec/NestedGroups
    end
  end
end
# rubocop:enable Metrics/BlockLength
