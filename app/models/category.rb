class Category < ActiveRecord::Base
  acts_as_nested_set

  has_many :translations, class_name: 'Category', primary_key: :uuid, foreign_key: :uuid

  scope :top_level, -> { where(parent_id: nil) }

  def self.import(locale='en')
    # json = File.read(Rails.root.join("tmp/categories.#{locale}.json"))
    # categories = ActiveSupport::JSON.decode(json)['response']['categories']
    foursquare = Foursquare2::Client.new(
      client_id: ENV['FSQ_CLIENT_ID'],
      client_secret: ENV['FSQ_CLIENT_SECRET'],
      api_version: '20130908',
      locale: locale
    )
    categories = foursquare.venue_categories
    rec_import(categories, locale)
  end

  private
  def self.rec_import(categories, locale='en', parent_id=nil)
    categories.each do |category|
      c = Category.find_or_create_by(uuid: category['id'], locale: locale) do |cat|
        cat.name = category['name']
        cat.plural_name = category['pluralName']
        cat.short_name = category['shortName']
        cat.icon_prefix = category['icon']['prefix']
        cat.icon_suffix = category['icon']['suffix']
        cat.parent_id = parent_id
      end
      next if category['categories'].blank?
      rec_import(category['categories'], locale, c.id)
    end
  end

end
