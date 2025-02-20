class SessionsController < ApplicationController

  auto_session_timeout_actions

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to '/posts'
    else 
      
      flash.now[:alert] = 'Invalid email/password combination' 
      render 'new' 
    end
  end

  def destroy
    log_out
    redirect_to '/login'
  end
end
