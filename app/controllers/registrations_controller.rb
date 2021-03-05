class RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(user_params)

    if @user.save!
      token = encode({ user_id: @user.id })
      render json: { auth_token: token, user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_message }, status: :unprocessable_entity
    end
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone)
  end
end