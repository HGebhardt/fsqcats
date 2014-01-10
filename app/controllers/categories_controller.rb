class CategoriesController < ApplicationController

  # GET /categories
  # GET /categories.json
  def index
    @icon_size = params[:is] || 32
    @categories = Category.where(locale: params[:locale] || 'de').order('lft ASC')
  end

  def compare
    @icon_size = params[:is] || 0
    @languages = {}
    (params[:tl].presence || 'en,de').split(',').each do |ll|
      @languages[ll] = Category.where(locale: ll).order('lft ASC')
    end
  end

  def show
    @category = Category.includes(:translations).where(uuid: params[:id], locale: params[:locale]).first
    @category = Category.includes(:translations).where(uuid: params[:id], locale: 'en').first if @category.nil?
  end

  def search
    @categories = Category.where("name ILIKE ?", "%#{params[:q]}%")
  end

  def redirect
    category = Category.find(params[:id])
    redirect_to category_path(locale: (params[:locale].presence || 'de'), id: category.uuid)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:uuid, :name, :plural_name, :short_name, :icon_prefix, :icon_suffix)
    end
end
