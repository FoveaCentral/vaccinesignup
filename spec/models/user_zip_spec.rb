# frozen_string_literal: true

# require "#{File.dirname(__FILE__)}/../spec_helper"

describe UserZip do
  context 'when a user already follows 90044' do
    before { UserZip.create(user_id: 1, zip: '90044') }

    context 'when following 90210' do
      let(:user_zip) { UserZip.new(user_id: 1, zip: '90210') }

      describe '#save' do
        subject { user_zip.save }

        it { should be true }
      end
    end
  end
end
