class Api::V1::AuthController < ApplicationController
  before_action :authorize_req, except: :login

  SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

  def login
    user = User.find_by_email(login_params[:email])
    p login_params
    if !user
      return render json: { errors: 'Usuario no encontrado.' }, status: :unauthorized
    end

    unless user&.valid_password?(login_params[:password])
      return render json: { errors: 'Las credenciales no son válidas.' }, status: :unauthorized
    end

    token = encode({ user_id: user.id })

    render json: { auth_token: token }, status: :ok
  end

  def login_params
    params.permit(:email, :password)
  end
end
