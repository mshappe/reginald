class UsersController < ApplicationController
  before_action :get_user, except: :index

  def index
    @q = policy_scope(User).order(:email).ransack(params[:q])
    @users = @q.result(distinct: true).page params[:page]
  end

  def show
  end

  def bless
    return head :bad_request unless user_params.has_key? :role
    return head :not_found unless user_params[:role].to_sym.in? User::VALID_ROLES
    @user.add_role user_params[:role].to_sym
    redirect_to users_path
  end

  def curse
    return head :bad_request unless user_params.has_key? :role
    return head :not_found unless user_params[:role].to_sym.in? User::VALID_ROLES
    @user.remove_role user_params[:role].to_sym
    redirect_to users_path
  end

  def edit
  end

  def update
  end

  protected

  def get_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(policy(@user).permitted_attributes)
  end
end
