class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(created_at: :desc)
    render 'admin/categories/show'
  end

  def index
    @categories = Category.all
    render 'admin/categories/index'
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_category_path(@category), notice: 'Category created successfully.'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
