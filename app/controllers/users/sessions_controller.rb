# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!, only: [:destroy]

  def create
    user = User.find_for_database_authentication(email: params[:user][:email])

    if user&.valid_password?(params[:user][:password])
      sign_in(user)
      render json: { user: }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    if user_signed_in?
      sign_out(resource_name)
      render json: { message: 'Logout successful' }
    else
      render json: { error: 'User not signed in' }, status: :unprocessable_entity
    end
  end

  # def destroy
  #   binding.pry
  #   token = request.headers['Authorization']&.split(' ')&.last
  #   decoded_token = JWT.decode(token, ENV['DEVISE_JWT_SECRET_KEY'], true, algorithm: 'HS256')

  #   Rails.logger.debug("Decoded Token: #{decoded_token}")

  #   sign_out(resource_name)
  #   render json: { message: 'Logout successful' }
  # end
end
