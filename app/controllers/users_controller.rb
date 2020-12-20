class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_method)
    if @user.save
      flash[:notice] = 'User Created Successfully'
    else
      render 'new'
    end
  end

  private 
  def user_method
    params.require(:user).permit(:username, :email, :password)
  end

end