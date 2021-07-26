# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AttendeePolicy, type: :policy do
  subject { described_class }

  let(:peon) { FactoryBot.create :user }
  let(:read_only) { FactoryBot.create :user, :when_read_only }
  let(:staff) { FactoryBot.create :user, :when_staff }
  let(:helpdesk) { FactoryBot.create :user, :when_helpdesk }
  let(:head) { FactoryBot.create :user, :when_head }
  let(:admin) { FactoryBot.create :user, :when_admin }

  permissions :index?, :show? do
    it { is_expected.to permit read_only }
    it { is_expected.to permit staff }
    it { is_expected.to permit head }
    it { is_expected.to permit admin }

    it { is_expected.not_to permit peon }
    it { is_expected.not_to permit nil }
  end

  permissions :edit?, :update? do
    it { is_expected.not_to permit staff }
    it { is_expected.to permit head }
    it { is_expected.to permit admin }

    it { is_expected.not_to permit read_only }
    it { is_expected.not_to permit peon }
    it { is_expected.not_to permit nil }
  end

  permissions :checkin?, :uncheckin?, :reissue? do
    it { is_expected.to permit staff }
    it { is_expected.to permit head }
    it { is_expected.to permit admin }

    it { is_expected.not_to permit read_only }
    it { is_expected.not_to permit peon }
    it { is_expected.not_to permit nil }
  end

  permissions :eject? do
    it { is_expected.to permit head }
    it { is_expected.to permit admin }

    it { is_expected.not_to permit read_only }
    it { is_expected.not_to permit staff }
    it { is_expected.not_to permit peon }
    it { is_expected.not_to permit nil }
  end

  permissions :new?, :create? do
    it { is_expected.not_to permit peon }
    it { is_expected.to permit admin }
    it { is_expected.to permit head }
    it { is_expected.not_to permit nil }
  end

  permissions :importer?, :import? do
    it { is_expected.not_to permit peon }
    it { is_expected.not_to permit head }
    it { is_expected.not_to permit helpdesk }
    it { is_expected.not_to permit staff }
    it { is_expected.not_to permit read_only }
    it { is_expected.not_to permit nil }
    it { is_expected.to permit admin }
  end

  permissions :destroy? do
    it do
      [peon, read_only, staff, helpdesk, head, admin].each do |u|
        expect(subject).not_to permit u
      end
    end
  end

  describe 'Scope' do
    subject(:scope) { Pundit.policy_scope!(user, Attendee) }

    before { FactoryBot.create_list :attendee, 10 }

    describe 'anon' do
      let(:user) { nil }

      it { is_expected.to be_blank }
    end

    describe 'peon' do
      let(:user) { peon }

      it { is_expected.to be_blank }
    end

    describe 'staff' do
      let(:user) { staff }

      it { is_expected.not_to be_blank }
    end

    describe 'head' do
      let(:user) { head }

      it { is_expected.not_to be_blank }
    end
  end
end
