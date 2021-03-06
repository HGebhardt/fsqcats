class Category < ActiveRecord::Base
  acts_as_nested_set

  has_many :translations, class_name: 'Category', primary_key: :uuid, foreign_key: :uuid

  default_scope { order('lft ASC') }
  scope :top_level, -> { where(parent_id: nil) }

  def to_param
    uuid
  end

  def self.import(locale='en')
    foursquare = Foursquare2::Client.new(
      client_id: ENV['FSQ_CLIENT_ID'],
      client_secret: ENV['FSQ_CLIENT_SECRET'],
      api_version: '20130908',
      locale: locale
    )
    categories = foursquare.venue_categories
    rec_import(categories, locale)
  end

  def icon(size=32)
    "#{self.icon_prefix}bg_#{size}#{self.icon_suffix}"
  end

  def name_for(locale=:en)
    @_translations ||= Hash[self.translations.pluck([:locale, :name])]
    @_translations[locale.to_s].presence || @_translations['en'].presence || self.name
  end

  private
  def self.rec_import(categories, locale='en', parent_id=nil)
    categories.each do |category|
      c = Category.find_or_initialize_by(uuid: category['id'], locale: locale)
      c.name = category['name']
      c.plural_name = category['pluralName']
      c.short_name = category['shortName']
      c.icon_prefix = category['icon']['prefix']
      c.icon_suffix = category['icon']['suffix']
      c.parent_id = parent_id
      c.save!

      next if category['categories'].blank?
      rec_import(category['categories'], locale, c.id)
    end
  end

end
