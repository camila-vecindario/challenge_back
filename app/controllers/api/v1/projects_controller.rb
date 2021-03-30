class Api::V1::ProjectsController < ApplicationController
  before_action :set_project, except: [:list]
  skip_before_action  :authorize_req, only: [:list]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_project_not_found

  def set_project
    @project = Project.find(params[:projectId])
  end

  def create
    project = Project.new(project_params)

    unless project.save!
      render json: { errors: project.errors.full_message }, status: :unprocessable_entity
    end

    price = PriceHistory.new(project: project, value: additional_params[:price])

    unless price.save!
      render json: { errors: price.errors.full_message }, status: :unprocessable_entity
    end

    project_access = ProjectAccess.new(project_id: project.id, user_id: @current_user.id, is_owner: true )

    unless project_access.save!
      render json: { errors: project_access.errors.full_message }, status: :unprocessable_entity
    end

    render json: { project: project, price: price, access: project_access }, status: :ok
  end

  def update
    @project.attributes = project_params[:project]
  end

  def list
    projects = Project.all.order(:created_at)
    if search_params[:type]
      projects = Project.where("type_project = ?", search_params[:type]).order(:created_at)
    end
    render json: projects.to_json(include: [:location]), status: :ok
  end

  def find
    render json: @project, status: :ok
  end

  def search
    projects = Project.where(name: search_params[:name])
    render json: projects, status: :ok
  end

  def project_params
    params
      .require(:project)
      .permit(:name, :type_project, :address, :has_vis, :private_area, :built_area, :bathrooms, :has_parking, :sales_room_emails, :location_id)
  end

  def additional_params
    params.require(:project).permit(:price)
  end

  def search_params
    params.permit(:type, :name)
  end

  def handle_project_not_found
    render json: { errors: "project record not found" }, status: :not_found
  end
end
