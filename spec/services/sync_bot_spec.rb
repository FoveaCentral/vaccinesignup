# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
describe SyncBot do
  describe '#call' do
    before {  allow(LocationSyncer).to receive(:call).and_return results }

    after { SyncBot.call }

    describe NotifyBot do
      subject { NotifyBot }

      context "when there's a new Location" do
        let(:results) { { new: 1 } }

        it { should receive(:call) }
      end
      context "when there's an updated Location" do
        let(:results) { { new: 0, updated: 1 } }

        it { should receive(:call) }
      end
    end
  end
end
