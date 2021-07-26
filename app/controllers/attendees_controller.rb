# frozen_string_literal: true

class AttendeesController < ApplicationController
  before_action :get_attendee, except: %i[index importer import]
  before_action :set_paper_trail_whodunnit

  def index
    @q = policy_scope(Attendee).order(:id).ransack(params[:q])
    @attendees = @q.result(distinct: true).page params[:page]
    respond_to do |format|
      format.json do
        render json: @attendees
      end
      format.html
    end
  end

  def show; end

  def checkin
    @attendee.checkin! by: current_user
    redirect_to @attendee
  end

  def uncheckin
    @attendee.uncheckin! by: current_user
    redirect_to @attendee
  end

  def reissue
    @attendee.reissue! by: current_user, pay_type: attendee_params[:pay_type]
    redirect_to @attendee
  end

  def eject
    @attendee.eject! by: current_user
    redirect_to @attendee
  end

  def importer
    authorize Attendee
  end

  def import
    authorize Attendee
    @file = attendee_params[:file]
    filename = Rails.root.join('tmp', @file.original_filename)
    File.open(filename, 'wb') do |f|
      f.write(@file.read)
    end
    AttendeeImportJob.perform_later(filename.to_s, current_user)
  end

  protected

  def get_attendee
    @attendee = Attendee.find(params[:id])
    authorize @attendee
  end

  def attendee_params
    params.require(:attendee).permit(:pay_type, :file)
  end
end
