class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy
  
  def new; end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      sign_in(user)
      remember(user) if params[:remember_me] == '1'
      flash[:success] = "Welcome, #{current_user.name_or_email}!!!"
      redirect_to root_path
    else
      flash[:warning] = "Incorrect email and/or password"
      render :new
    end
  end

  def destroy
    forget current_user
    sign_out
    flash[:success] = "Good bye!"
    redirect_to root_path
  end
end
