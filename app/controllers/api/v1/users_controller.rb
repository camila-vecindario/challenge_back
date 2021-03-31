class Api::V1::UsersController < ApplicationController
  before_action :authorize_req, :set_user
  rescue_from ActiveRecord::RecordNotFound, with: :handle_user_not_found

  def set_user
    @user = User.find(params[:userId])
  end

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def find
    render json: @user, status: :ok
  end

  def find_projects
    render json: @user.projects, status: :ok
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone)
  end

  def handle_user_not_found
    render json: { errors: "User record not found" }, status: :not_found
  end
end
