# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AttendeeNotes', type: :request do
  let(:attendee) { FactoryBot.create :attendee }
  let(:head) { FactoryBot.create :user, :when_confirmed, :when_head }

  describe 'GET /new' do
    it 'returns http success' do
      sign_in head

      get '/attendee_notes/new', params: { attendee_note: { attendee_id: attendee.id, note_type: 'general' } }
      expect(response).to render_template :new
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      sign_in head
      post '/attendee_notes',
           params: { attendee_note: { attendee_id: attendee.id, note: '1234568790', note_type: 'general' } }
      expect(response).to redirect_to attendee
    end
  end
end
