# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UserPolicy, type: :policies do
  subject { described_class }

  let(:peon) { FactoryBot.create :user }
  let(:staff) { FactoryBot.create :user, :when_staff }
  let(:head) { FactoryBot.create :user, :when_head }
  let(:helpdesk) { FactoryBot.create :user, :when_helpdesk }
  let(:admin) { FactoryBot.create :user, :when_admin }

  # A new user can't do anything here
  permissions :index?, :show?, :edit?, :update?, :bless? do
    it { is_expected.not_to permit peon }
    it { is_expected.not_to permit staff }
    it { is_expected.to permit head }
    it { is_expected.to permit admin }
    it { is_expected.to permit helpdesk }
  end

  describe 'Scope' do
    subject(:scope) { Pundit.policy_scope!(user, User) }

    before { FactoryBot.create_list :user, 10, :when_confirmed }

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

      it { is_expected.to be_blank }
    end

    describe 'head' do
      let(:user) { head }

      it { is_expected.not_to be_blank }
    end

    describe 'admin' do
      let(:user) { admin }

      it { is_expected.not_to be_blank }
    end
  end
end
