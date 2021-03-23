# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
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
end
