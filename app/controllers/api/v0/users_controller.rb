class Api::V0::UsersController < ApplicationController
  def create
    if params[:password] == params[:password_confirmation]
      user = User.create!(user_params)
      render json: UserSerializer.new(user), status: 201
    else params[:password] != params[:password_confirmation]
      # render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
  
end