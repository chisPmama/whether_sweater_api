class Api::V0::UsersController < ApplicationController
  def create
    if params[:password] == params[:password_confirmation]
      binding.pry
      # User.create(user_params)
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
  
end