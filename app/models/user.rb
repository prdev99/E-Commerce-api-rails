# api/app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  # devise :database_authenticatable, :validatable,
  #        :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_one_attached :picture

  def generate_jwt
    JWT.encode({ id:, exp: 1.day.from_now.to_i }, ENV['DEVISE_JWT_SECRET_KEY'], 'HS256')
  end
end
