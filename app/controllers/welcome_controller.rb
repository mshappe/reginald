# frozen_string_literal: true

class WelcomeController < ApplicationController
  after_action :verify_authorized, except: :index

  def index
    redirect_to attendees_url if current_user.has_any_role?
  end
end
