class UsersController < ApplicationController
  before_action :authorize_req

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def find
    user = User.find(params[:userId])
    print "Find user #{user}"
    render json: user, status: :ok
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone)
  end
end
