class CategoriesController < ApplicationController
  def index
    if params[:search].present?
      @categories = Category.where("name LIKE ?", "%#{params[:search]}%")
    else
      @categories = Category.all
    end
  end
end
