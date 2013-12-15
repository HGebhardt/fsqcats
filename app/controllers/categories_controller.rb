class CategoriesController < ApplicationController

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

  def show
    @category = Category.includes(:translations).where(uuid: params[:id], locale: params[:locale]).first
  end

  def search
    @categories = Category.where("name ILIKE ?", "%#{params[:q]}%")
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:uuid, :name, :plural_name, :short_name, :icon_prefix, :icon_suffix)
    end
end
