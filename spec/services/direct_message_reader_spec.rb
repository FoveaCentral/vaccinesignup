# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
# rubocop:disable Metrics/BlockLength
describe DirectMessageReader do
  describe '#call' do
    let(:results) { subject.call }

    subject { DirectMessageReader.new(messages) }

    context 'when a user subscribes to a zip' do
      let(:messages) { [subscribe_message] }
      let(:subscribe_message) do
        msg = double
        allow(msg).to receive(:id).and_return(1)
        allow(msg).to receive(:sender_id).and_return(167_894_675)
        allow(msg).to receive(:recipient_id).and_return(490_732_052)
        allow(msg).to receive(:text).and_return('90210')
        msg
      end

      it { expect(results).to eq({ stopped: 0, subscribed: 1 }) }

      context 'when a user unsubscribes' do
        let(:messages) { [subscribe_message, unsubscribe_message] }
        let(:unsubscribe_message) do
          msg = double
          allow(msg).to receive(:id).and_return(2)
          allow(msg).to receive(:sender_id).and_return(167_894_675)
          allow(msg).to receive(:recipient_id).and_return(490_732_052)
          allow(msg).to receive(:text).and_return('stop')
          msg
        end

        it { expect(results).to eq({ stopped: 1, subscribed: 1 }) }
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
