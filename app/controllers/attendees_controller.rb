# frozen_string_literal: true

class AttendeesController < ApplicationController
  before_action :get_attendee, except: %i[index new create importer import]
  before_action :set_paper_trail_whodunnit

  def index
    redirect_to root_path if current_user.roles.blank?
    @q = policy_scope(Attendee).order(:id).ransack(params[:q])
    @attendees = if params[:q].present?
                   @q.result(distinct: true).page params[:page]
                 else
                   Attendee.none.page params[:page]
                 end
  end

  def show; end

  def new
    @attendee = Attendee.new
    authorize @attendee
  end

  def create
    @attendee = Attendee.new(attendee_params)
    authorize @attendee

    if @attendee.save
      redirect_to @attendee, notice: 'Attendee created!'
    else
      render :new, alert: 'Attendee could not be created!'
    end
  end

  def edit; end

  def update
    if @attendee.update!(attendee_params)
      redirect_to attendee_path(@attendee), notice: 'Attendee updated!'
    else
      render :edit, alert: 'Something is not right!'
    end
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
    redirect_to attendees_path, notice: 'Import in progress'
  end

  protected

  def get_attendee
    @attendee = Attendee.find(params[:id])
    authorize @attendee
  end

  def attendee_params
    permit = %i[pay_type file]

    if current_user.has_any_role? :staff, :helpdesk, :head, :admin
      permit += %i[address1 address2 area_code badge_name
                   city country email emergency_contact
                   guest_badge legal_name membership_type
                   phone_number preferred_first_name preferred_last_name
                   state zip registered_at registered_by]
    end

    params.require(:attendee).permit(permit)
  end
end
