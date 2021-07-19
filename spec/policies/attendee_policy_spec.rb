require 'spec_helper'

RSpec.describe AttendeePolicy, type: :policy do
  let(:user) { User.new }

  subject { described_class }

  permissions :index?, :show?, :checkin?, :uncheckin?, :reissue?, :eject? do
    it { is_expected.to permit user }
    it { is_expected.not_to permit nil }
  end

  permissions :new?, :create?, :edit?, :update?, :destroy? do
    it { is_expected.not_to permit user }
    it { is_expected.not_to permit nil }
  end
end
