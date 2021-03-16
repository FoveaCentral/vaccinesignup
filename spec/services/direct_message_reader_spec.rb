# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
# rubocop:disable Metrics/BlockLength
describe DirectMessageReader do
  describe '#call' do
    subject { DirectMessageReader.call(messages) }

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

      context 'when DM is just a zip' do
        it { should eq({ stopped: 0, subscribed: 1 }) }
      end

      context 'when DM embeds two zip in other text' do
        let(:subscribe_message) do
          msg = double
          allow(msg).to receive(:id).and_return(1)
          allow(msg).to receive(:sender_id).and_return(167_894_675)
          allow(msg).to receive(:recipient_id).and_return(490_732_052)
          allow(msg).to receive(:text).and_return('LA County ranges from neighborhoods like 90210 to 90044.')
          msg
        end

        it { should eq({ stopped: 0, subscribed: 2 }) }
      end

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

        it { should eq({ stopped: 1, subscribed: 1 }) }
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
