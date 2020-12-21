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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_method)
      flash[:notice] = "User details updated successfully"
      redirect_to articles_path
    else
      render "edit"
    end
  end

  def show
    @user = User.find(params[:id])
    @article = @user.articles
  end
  

  private 
  def user_method
    params.require(:user).permit(:username, :email, :password)
  end

end