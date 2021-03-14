# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
describe NotifyBot do
  describe '#call' do
    before {  allow(DirectMessageReader).to receive(:call).and_return results }

    after { NotifyBot.call }

    let(:results) { { subscribed: 1 } }

    describe Notifier do
      subject { Notifier }

      it { should receive(:call) }
    end
  end
end
