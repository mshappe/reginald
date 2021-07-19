class AttendeesController < ApplicationController
  before_action :get_attendee, except: :index

  def index
    @q = policy_scope(Attendee).order(:badge_number).ransack(params[:q])
    @attendees = @q.result(distinct: true).page params[:page]
    respond_to do |format|
      format.json {
        render json: @attendees
      }
      format.html
    end
  end

  def show
  end

  def checkin
    @attendee.checkin!
    redirect_to @attendee
  end

  def uncheckin
    @attendee.uncheckin!
    redirect_to @attendee
  end

  def reissue
    @attendee.reissue!
    redirect_to @attendee
  end

  def eject
    @attendee.eject!
    redirect_to @attendee
  end

  protected

  def get_attendee
    @attendee = Attendee.find(params[:id])
    authorize @attendee
  end
end
