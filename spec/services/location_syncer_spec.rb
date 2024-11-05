# Copyright the @vaccinesignup contributors.
# SPDX-License-Identifier: CC0-1.0
# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
LOCATION_ATTRIBUTES = {
  la_id: '5462',
  name: 'Rite Aid Pharmacy #5462',
  addr1: '300 North Canon Drive',
  addr2: 'Beverly Hills, CA 90210',
  link: 'https://www.riteaid.com/pharmacy/covid-qualifier'
}.freeze

# rubocop:disable Metrics/BlockLength
describe LocationSyncer do
  let(:location) { Location.first }
  let(:locations) { JSON.parse(File.read('./spec/fixtures/locations.json')) }

  describe '#call' do
    subject { described_class.call(locations) }

    context 'when no Locations exist' do
      it { is_expected.to include({ total: 1, new: 1, updated: 0 }) }

      # rubocop:disable RSpec/NestedGroups, RSpec/ContextWording
      context 'creates Location' do
        before { described_class.call(locations) }

        LOCATION_ATTRIBUTES.each do |key, value|
          describe "Location##{key}" do
            subject { location.send(key) }

            it { is_expected.to eq value }
          end
        end
      end
      # rubocop:enable RSpec/NestedGroups, RSpec/ContextWording
    end

    context 'when a matching Location exists' do
      before { FactoryBot.create(:location, :with_bad_name) }

      it { is_expected.to include({ total: 1, new: 0, updated: 1 }) }

      # rubocop:disable RSpec/NestedGroups, RSpec/ContextWording
      context 'updates Location' do
        before { described_class.call(locations) }

        LOCATION_ATTRIBUTES.each do |key, value|
          describe "Location##{key}" do
            subject { location.send(key) }

            it { is_expected.to eq value }
          end
        end
      end
      # rubocop:enable RSpec/NestedGroups, RSpec/ContextWording
    end
  end
end
# rubocop:enable Metrics/BlockLength
