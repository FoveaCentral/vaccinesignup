# Copyright the @vaccinesignup contributors.
# SPDX-License-Identifier: CC0-1.0
# frozen_string_literal: true

# require "#{File.dirname(__FILE__)}/../spec_helper"

describe UserZip do
  context 'when a user already follows a zip' do
    before { described_class.create(user_id: 1, zip: '90044') }

    context 'when following another zip' do
      let(:user_zip) { described_class.new(user_id: 1, zip: '90210') }

      describe '#save' do
        subject { user_zip.save }

        it { is_expected.to be true }
      end
    end
  end
end
