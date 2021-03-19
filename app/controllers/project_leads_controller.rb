class ProjectLeadsController < ApplicationController

  DEFAULT_PASS = "WQ123@45"

  def create
    user = User.find_by_email([leads_params[:email]])

    unless user
      user = User.new
      user.email = leads_params[:email]
      user.phone = leads_params[:phone]
      user.password = DEFAULT_PASS
      user.first_name = leads_params[:first_name]
      user.last_name = leads_params[:last_name]

      unless user.save!
        render json: { errors: user.errors.full_message }, status: :unprocessable_entity
      end
    end

    lead = ProjectLeads.new(project_id: params[:projectId], user_id: user.id)

    unless lead.save!
      render json: { errors: lead.errors.full_message }, status: :unprocessable_entity
    end

    render json: lead, status: :ok
  end

  # TODO list project leads by Id
  def list
    puts "List project #{params[:projectId]} leads"
  end

  def leads_params
    params.permit(:first_name, :last_name, :phone, :email)
  end
end
