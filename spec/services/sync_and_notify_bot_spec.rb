# Copyright the @vaccinesignup contributors.
# SPDX-License-Identifier: CC0-1.0
# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
describe SyncAndNotifyBot do
  describe '#call' do
    before { allow(LocationSyncer).to receive(:call).and_return results }

    after { described_class.call }

    describe Notifier do
      subject { described_class }

      # rubocop:disable RSpec/NestedGroups
      context "when there's a new Location" do
        let(:results) { { new: 1, zips: ['00501'] } }

        # rubocop:disable RSpec/SubjectStub
        it { is_expected.to receive(:call) }
        # rubocop:enable RSpec/SubjectStub
      end

      context "when there's an updated Location" do
        let(:results) { { new: 0, updated: 1, zips: ['00501'] } }

        # rubocop:disable RSpec/SubjectStub
        it { is_expected.to receive(:call) }
        # rubocop:enable RSpec/SubjectStub
      end
      # rubocop:enable RSpec/NestedGroups
    end
  end
end
