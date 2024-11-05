# Copyright the @vaccinesignup contributors.
# SPDX-License-Identifier: CC0-1.0
# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"

USER_FACING_FIELDS = %w[name addr1 addr2 link].freeze

# rubocop:disable Metrics/BlockLength
describe Location do
  describe '.find_by_best_key' do
    subject { described_class.find_by_best_key(address1:, la_id:) }

    let(:address1) { nil }
    let(:la_id) { nil }
    let(:location) { FactoryBot.create(:location) }

    context 'with nil :address1 and :la_id' do
      before { location }

      it { is_expected.to be_nil }
    end

    context 'with present :la_id' do
      let(:la_id) { '5462' }

      # rubocop:disable RSpec/ImplicitExpect
      it { should eq location }
      # rubocop:enable RSpec/ImplicitExpect
    end

    context 'with present :address1' do
      let(:address1) { '300 North Canon Drive' }

      # rubocop:disable RSpec/ImplicitExpect
      it { should eq location }
      # rubocop:enable RSpec/ImplicitExpect
    end
  end

  describe '#user_facing_attributes_changed?' do
    context 'when user-facing attributes change' do
      USER_FACING_FIELDS.each do |attr|
        # rubocop:disable RSpec/NestedGroups
        context "when ##{attr} changes" do
          subject { location.user_facing_attributes_changed? }

          let(:location) { described_class.new(attr => 'changed value') }

          it { is_expected.to be true }
        end
        # rubocop:enable RSpec/NestedGroups
      end
    end

    context "when user-facing don't attributes change" do
      (described_class.column_names - USER_FACING_FIELDS).each do |attr|
        # rubocop:disable RSpec/NestedGroups
        context "when ##{attr} changes" do
          subject { location.user_facing_attributes_changed? }

          let(:location) { described_class.new(attr => 'changed value') }

          it { is_expected.to be false }
        end
        # rubocop:enable RSpec/NestedGroups
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
