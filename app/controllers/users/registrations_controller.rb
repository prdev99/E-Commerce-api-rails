# app/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_product, only: [:update]
  def create
    user = User.new(user_params)

    if user.save
      render json: { user:, message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    return unless @user.present?
    return render json: { message: 'User Error' } unless @user.update(user_params)

    render json: @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :full_name, :address, :phone_number, :title, :about, :picture)
  end
end
