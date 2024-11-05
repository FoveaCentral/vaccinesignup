# Copyright the @vaccinesignup contributors.
# SPDX-License-Identifier: CC0-1.0
# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
describe DirectMessageReader do
  describe '#call' do
    subject { described_class.call(messages) }

    context 'when a user subscribes to a zip' do
      let(:messages) { [subscribe_message] }
      let(:subscribe_message) do
        msg = double
        allow(msg).to receive_messages(id: 1, sender_id: 167_894_675, recipient_id: 490_732_052, text: '90210')
        msg
      end

      it { is_expected.to eq({ stopped: 0, subscribed: 1 }) }

      # rubocop:disable RSpec/NestedGroups
      context 'when a user unsubscribes' do
        let(:messages) { [subscribe_message, unsubscribe_message] }
        let(:unsubscribe_message) do
          msg = double
          allow(msg).to receive_messages(id: 2, sender_id: 167_894_675, recipient_id: 490_732_052, text: 'stop')
          msg
        end

        it { is_expected.to eq({ stopped: 1, subscribed: 1 }) }
      end
      # rubocop:enable RSpec/NestedGroups
    end
  end
end
