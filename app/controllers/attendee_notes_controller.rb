# frozen_string_literal: true

class AttendeeNotesController < ApplicationController
  before_action :create_attendee_note, only: %i[new create]
  def new; end

  def create
    if @attendee_note.save
      notice = 'Note saved'
      if @attendee_note.note_type == 'ejection'
        @attendee.eject! by: current_user
        notice = 'Attendee ejected!'
      end
      redirect_to @attendee, notice: notice
    else
      render :new, alert: 'There was an error'
    end
  end

  private

  def create_attendee_note
    @attendee = Attendee.find attendee_note_params[:attendee_id]
    @attendee_note = AttendeeNote.new(attendee_note_params.merge(user: current_user))
    authorize @attendee_note
  end

  def attendee_note_params
    params.require(:attendee_note).permit(:attendee_id, :note, :note_type)
  end
end
