class Api::V0::UsersController < ApplicationController
  def create
    if params[:email].blank?
      error_response("E-mail cannot be blank.", 422)
    elsif params[:password].blank? || params[:password_confirmation].blank?
      error_response("Missing password entry.", 422)
    elsif params[:password] != params[:password_confirmation]
      error_response("Password and password confirmation do not match.", 422)
    else
      user = User.create!(user_params)
      render json: UsersSerializer.new(user), status: :created
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UsersSerializer.new(user), status: 200
    else
      error_response("Invalid email or password.", 422)
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def error_response(message, status)
    render json: ErrorSerializer.new(ErrorMessage.new(message, status))
    .serialize_json, status: :unprocessable_entity
  end
  
end