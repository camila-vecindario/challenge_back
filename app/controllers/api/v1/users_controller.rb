class Api::V1::UsersController < ApplicationController
  before_action :authorize_req
  before_action :set_user, except: [:index, :find_projects]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_user_not_found

  def set_user
    @user = User.find(params[:userId])
  end

  def index
    users = User.all
    render json: users, status: :ok
  end

  def find
    render json: @user, status: :ok
  end

  def find_projects
    projects = @current_user.projects
    if project_params[:name].present?
      projects = projects.search_by_name(project_params[:name])
    end
    render json: projects.as_json(only: [:id, :name]), status: :ok
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone)
  end

  def project_params
    params.permit(:name)
  end

  def handle_user_not_found
    render json: { errors: "User record not found" }, status: :not_found
  end
end
