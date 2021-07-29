# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttendeeNotePolicy, type: :policy do
  subject { described_class }

  let(:peon) { FactoryBot.create :user }
  let(:read_only) { FactoryBot.create :user, :when_read_only }
  let(:staff) { FactoryBot.create :user, :when_staff }
  let(:helpdesk) { FactoryBot.create :user, :when_helpdesk }
  let(:head) { FactoryBot.create :user, :when_head }
  let(:admin) { FactoryBot.create :user, :when_admin }

  permissions :new?, :create? do
    it { is_expected.to permit staff }
    it { is_expected.to permit helpdesk }
    it { is_expected.to permit head }
    it { is_expected.to permit admin }

    it { is_expected.not_to permit peon }
    it { is_expected.not_to permit read_only }
  end

  permissions :index?, :show?, :edit?, :update?, :destroy? do
    it { is_expected.not_to permit peon }
    it { is_expected.not_to permit read_only }
    it { is_expected.not_to permit staff }
    it { is_expected.not_to permit helpdesk }
    it { is_expected.not_to permit head }
    it { is_expected.not_to permit admin }
  end
end
