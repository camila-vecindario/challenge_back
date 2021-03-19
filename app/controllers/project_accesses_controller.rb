class ProjectAccessesController < ApplicationController

  def create
    access = ProjectAccess.new
    access.project_id = access_params[:project]
    access.user_id = access_params[:user]
    access.is_owner = false

    if access.save!
      render json: access, status: :ok
    elsif render json: { errors: access.errors.full_message }, status: :unprocessable_entity
    end
  end

  # TODO list project members by id
  def project_members

    # members = ProjectAccess.where(project, [params[:projectId]])
    # render json: members
  end

  def access_params
    params.permit(:project, :user)
  end

end
