class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Categories created successfully"
      redirect_to @category
    else
      render = "new"
    end
  end
  

  def index
    @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])  
    @article = @category.articles
  end

  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "Categories updated successfully"
      redirect_to @category
    else
      render 'edit'
    end
  end

  private
  
  def category_params
    params.require(:category).permit(:name)
  end

  private

  def require_admin
    if ((!logged_in?) || (logged_in? && !current_user.admin?))
      flash[:alert] = "Only admins can perform that action"
      redirect_to categories_path
    end
  end
  

end