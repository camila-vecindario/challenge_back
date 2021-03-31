class Api::V1::ProjectLeadsController < ApplicationController
  skip_before_action  :authorize_req, only: [:create]

  def create
    user = User.find_by_email([leads_params[:email]])

    unless user
      user = User.new(leads_params)
      user.password = Devise.friendly_token[0, 20]
      unless user.save!
        render json: { errors: user.errors.full_message }, status: :unprocessable_entity
      end
    end

    lead = ProjectLead.new(project_id: params[:projectId], user_id: user.id)

    unless lead.save!
      render json: { errors: lead.errors.full_message }, status: :unprocessable_entity
    end

    LeadsMailer.send_lead_email(Project.find(params[:projectId]), user).deliver
    render json: lead, status: :ok
  end

  def list
    project = Project.find(params[:projectId])
    render json: project.leads, status: :ok
  end

  def leads_params
    params.permit(:first_name, :last_name, :phone, :email)
  end
end
