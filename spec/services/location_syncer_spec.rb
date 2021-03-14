# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
describe LocationSyncer do
  let(:locations) { JSON.parse(File.read('./spec/fixtures/locations.json')) }

  describe '#call' do
    subject { LocationSyncer.call(locations) }

    context 'when no Locations exist' do
      it { should eq({ total: 1, new: 1, updated: 0 }) }
    end

    context 'when a matching Location exists' do
      before { FactoryBot.create(:location) }

      it { should eq({ total: 1, new: 0, updated: 1 }) }
    end
  end
end
