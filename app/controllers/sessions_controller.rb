class SessionsController < ApplicationController
  
  skip_before_action :require_user, only: [:new, :create]
  
  def new
  end

  # def create
  #   user = User.find_by(email: params[:session][:email])
  #   if user && user.authenticate(params[:session][:password])
  #     session[:user_id] = user.id
  #     redirect_to products_path, notice: 'Logged in!'
  #   else
  #     Rails.logger.error("Login failed for email: #{params[:session][:email]}")
  #     redirect_to login_path, alert: 'Email or password is incorrect.'
  #   end
  # end

  def create
    user = User.authenticate_with_credentials(params[:session][:email], params[:session][:password])
    if user
      session[:user_id] = user.id
      redirect_to products_path, notice: 'Logged in!'
    else
      Rails.logger.error("Login failed for email: #{params[:session][:email]}")
      redirect_to login_path, alert: 'Email or password is incorrect.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to [:products], notice: 'Logged out!'
  end

end