json.array!(@categories) do |category|
  json.extract! category, :uuid, :name, :plural_name, :short_name, :icon_prefix, :icon_suffix
  json.url category_url(category, format: :json)
end
