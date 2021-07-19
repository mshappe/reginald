class WelcomeController < ApplicationController
  after_action :verify_authorized, except: :index

  def index
    redirect_to attendees_url if current_user
  end
end
