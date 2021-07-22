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

  protected

  def get_attendee
    @attendee = Attendee.find(params[:id])
    authorize @attendee
  end

  
  def attendee_params
    params.require(:attendee).permit(:pay_type)
  end
end
