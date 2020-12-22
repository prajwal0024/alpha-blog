class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :edit, :destroy]
  before_action :require_user, except: [:show, :index, :new, :create]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @users = User.all
  end
  
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_method)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'User Created Successfully'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_method)
      flash[:notice] = "User details updated successfully"
      redirect_to @user
    else
      render "edit"
    end
  end

  def show
    @article = @user.articles
  end
  
  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all assosiated articles deleted"
    redirect_to articles_path
  end
  

  private 

  def user_method
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit your own profile"
      redirect_to @user
    end
  end
  

end