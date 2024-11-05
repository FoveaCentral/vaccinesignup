# Copyright the @vaccinesignup contributors.
# SPDX-License-Identifier: CC0-1.0
# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"
describe NotifyBot do
  describe '#call' do
    before { allow(DirectMessageReader).to receive(:call).and_return results }

    after { described_class.call }

    let(:results) { { subscribed: 1 } }

    describe Notifier do
      subject { described_class }

      # rubocop:disable RSpec/SubjectStub
      it { is_expected.to receive(:call) }
      # rubocop:enable RSpec/SubjectStub
    end
  end
end
