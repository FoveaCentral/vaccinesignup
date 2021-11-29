# Copyright the @vaccinesignup contributors.
# SPDX-License-Identifier: CC0-1.0
# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"

USER_FACING_FIELDS = %w[name addr1 addr2 link].freeze

# rubocop:disable Metrics/BlockLength
describe Location do
  describe '.find_by_best_key' do
    subject { Location.find_by_best_key(address1: address1, la_id: la_id) }

    let(:address1) { nil }
    let(:la_id) { nil }
    let(:location) { FactoryBot.create(:location) }

    context 'with nil :address1 and :la_id' do
      before { location }

      it { should eq nil }
    end
    context 'with present :la_id' do
      let(:la_id) { '5462' }

      it { should eq location }
    end
    context 'with present :address1' do
      let(:address1) { '300 North Canon Drive' }

      it { should eq location }
    end
  end
  describe '#user_facing_attributes_changed?' do
    context 'when user-facing attributes change' do
      USER_FACING_FIELDS.each do |attr|
        context "when ##{attr} changes" do
          let(:location) { Location.new(attr => 'changed value') }

          subject { location.user_facing_attributes_changed? }

          it { should be true }
        end
      end
    end
    context "when user-facing don't attributes change" do
      (Location.column_names - USER_FACING_FIELDS).each do |attr|
        context "when ##{attr} changes" do
          let(:location) { Location.new(attr => 'changed value') }

          subject { location.user_facing_attributes_changed? }

          it { should be false }
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
