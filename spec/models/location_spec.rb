# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"

WATCHED_FIELDS = %w[name addr1 addr2 link].freeze

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
  describe '#watched_attributes_changed?' do
    context 'when watched attributes change' do
      WATCHED_FIELDS.each do |attr|
        context "when ##{attr} changes" do
          let(:location) { Location.new(attr => 'changed value') }

          subject { location.watched_attributes_changed? }

          it { should be true }
        end
      end
    end
    context "when watched don't attributes change" do
      (Location.column_names - WATCHED_FIELDS).each do |attr|
        context "when ##{attr} changes" do
          let(:location) { Location.new(attr => 'changed value') }

          subject { location.watched_attributes_changed? }

          it { should be false }
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
