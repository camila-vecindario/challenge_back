class Api::V1::RegistrationsController < Devise::RegistrationsController

  ADMIN_ROLE = 'ADMIN'

  def create
    user = User.new(user_params)
    user.picture.attach(user_params[:picture])

    if (user_params[:role] === ADMIN_ROLE)
      user.add_role :admin
    elsif
      user.add_role :client
    end

    if user.save!
      token = encode({ user_id: user.id })
      render json: { auth_token: token, user: user }, status: :created
    else
      render json: { errors: user.errors.full_message }, status: :unprocessable_entity
    end
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone, :role, :picture)
  end
end