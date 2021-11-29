# Copyright the @vaccinesignup contributors.
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
    subject { LocationSyncer.call(locations) }

    context 'when no Locations exist' do
      it { should include({ total: 1, new: 1, updated: 0 }) }

      context 'creates Location' do
        before { LocationSyncer.call(locations) }

        LOCATION_ATTRIBUTES.each do |key, value|
          describe "Location##{key}" do
            subject { location.send(key) }

            it { should eq value }
          end
        end
      end
    end
    context 'when a matching Location exists' do
      before { FactoryBot.create(:location, :with_bad_name) }

      it { should include({ total: 1, new: 0, updated: 1 }) }

      context 'updates Location' do
        before { LocationSyncer.call(locations) }

        LOCATION_ATTRIBUTES.each do |key, value|
          describe "Location##{key}" do
            subject { location.send(key) }

            it { should eq value }
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
