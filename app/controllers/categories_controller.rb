class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  # GET /categories
  # GET /categories.json
  def index
    @icon_size = params[:is] || 32
    @categories = Category.where(locale: params[:locale] || 'de').order('lft ASC')
  end

  def compare
    @icon_size = params[:is] || 0
    @categories_en = Category.where(locale: 'en').order('lft ASC')
    @categories_de = Category.where(locale: 'de').order('lft ASC')
    @categories_fr = Category.where(locale: 'fr').order('lft ASC')
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  def search
    @categories = Category.where("name ILIKE ?", "%#{params[:q]}%")
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
