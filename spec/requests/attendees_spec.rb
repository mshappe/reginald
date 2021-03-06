# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Attendees', type: :request do
  let(:user) { FactoryBot.create :user, :when_confirmed, :when_staff }
  let(:head) { FactoryBot.create :user, :when_confirmed, :when_head }

  describe 'GET /index' do
    describe 'logged in user' do
      it do
        sign_in user

        get '/attendees'
        expect(response).to render_template :index
      end
    end

    describe 'anonymous' do
      it do
        get '/attendees'
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /show' do
    let(:attendee) { FactoryBot.create :attendee }

    describe 'logged in user' do
      it 'works' do
        sign_in user

        get attendee_path(attendee)
        expect(response).to render_template :show
      end
    end

    describe 'anonymous' do
      it 'bounces' do
        get attendee_path(attendee)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'checkin' do
    let(:attendee) { FactoryBot.create :attendee }

    describe 'logged in user' do
      it 'works' do
        sign_in user

        patch checkin_attendee_path(attendee)
        expect(response).to redirect_to attendee_path(attendee)
      end
    end

    describe 'anonymous' do
      it 'bounces' do
        patch checkin_attendee_path(attendee)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'uncheckin' do
    let(:attendee) { FactoryBot.create :attendee, aasm_state: :checked_in }

    describe 'logged in user' do
      it 'works' do
        sign_in user

        patch uncheckin_attendee_path(attendee)
        expect(response).to redirect_to attendee_path(attendee)
      end
    end

    describe 'anonymous' do
      it 'bounces' do
        patch uncheckin_attendee_path(attendee)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'reissue' do
    let(:attendee) { FactoryBot.create :attendee, aasm_state: :checked_in }

    describe 'logged in user' do
      it 'works' do
        sign_in user

        patch reissue_attendee_path(attendee), params: { attendee: { dummy: true } }
        expect(response).to redirect_to attendee_path(attendee)
      end
    end

    describe 'anonymous' do
      it 'bounces' do
        patch reissue_attendee_path(attendee)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'eject' do
    let(:attendee) { FactoryBot.create :attendee, aasm_state: :checked_in }

    describe 'logged in head' do
      it 'works' do
        sign_in head

        patch eject_attendee_path(attendee)
        expect(response).to redirect_to attendee_path(attendee)
      end
    end

    describe 'anonymous' do
      it 'bounces' do
        patch eject_attendee_path(attendee)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
