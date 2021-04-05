class Api::V1::AuthController < ApplicationController
  before_action :authorize_req, except: [:login, :create]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_validations

  ADMIN_ROLE = 'ADMIN'

  def login
    user = User.find_by_email(login_params[:email])

    if !user
      return render json: { errors: 'Usuario no encontrado.' }, status: :unauthorized
    end

    unless user&.valid_password?(login_params[:password])
      return render json: { errors: 'Las credenciales no son válidas.' }, status: :unauthorized
    end

    token = encode({ user_id: user.id })

    render json: { auth_token: token, user: user.as_json(methods: :isAdmin, except: [:id, :created_at, :updated_at]) }, status: :ok
  end

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

  def login_params
    params.permit(:email, :password)
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone, :role, :picture)
  end

  def handle_record_validations
    render json: { errors: { email: "El correo ya está registrado" }  }
  end

end
