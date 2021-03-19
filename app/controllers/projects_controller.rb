class ProjectsController < ApplicationController

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

  # TODO update partially project
  def update
    project = Project.find(params[:projectId])
    puts "Vamo' a actualizar #{project.name}"
  end

  def list
    projects = Project.all
    render json: projects, status: :ok
  end

  def find
    project = Project.find(params[:projectId])
    render json: project, status: :ok
  end

  # TODO search project by slug
  def search
    puts "Search project"
  end

  def project_params
    params
      .require(:project)
      .permit(:name, :type_project, :address, :has_vis, :private_area, :built_area, :bathrooms, :has_parking, :sales_room_emails, :location_id)
  end

  def additional_params
    params.require(:project).permit(:price)
  end

end
