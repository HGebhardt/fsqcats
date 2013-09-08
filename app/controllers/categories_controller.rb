class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.where(locale: params[:locale] || 'de')
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:uuid, :name, :plural_name, :short_name, :icon_prefix, :icon_suffix)
    end
end
