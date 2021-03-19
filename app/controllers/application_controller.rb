class ApplicationController < ActionController::API
  before_action :authorize_req

  SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

  def not_found
    render json: { error: 'Resource not found' }
  end

  def encode(payload, expiration = 24.hours.from_now)
    payload[:expiration] = expiration.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end

  def authorize_req
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = decode(header)
      print "#{@decoded}"
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

end
