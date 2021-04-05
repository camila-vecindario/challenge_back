class Api::V1::ProjectAccessesController < ApplicationController

  def create
    access = ProjectAccess.new(:access_params)
    access.is_owner = false

    if access.save!
      render json: access, status: :ok
    elsif render json: { errors: access.errors.full_message }, status: :unprocessable_entity
    end
  end

  def project_members
    project = Project.find(params[:projectId])
    render json: project.allowed_users, status: :ok
  end

  def access_params
    params.permit(:project, :user)
  end

end
