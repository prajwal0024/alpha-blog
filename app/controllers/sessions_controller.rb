class SessionsController < ApplicationController

  def new
    
  end

  def create
    # Check if user exsists
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Login Successful"
      redirect_to user
    else
      flash.now[:alert] = "Invalid Credentials"
      render "new"
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged Out"
    redirect_to root_path
  end
  
end