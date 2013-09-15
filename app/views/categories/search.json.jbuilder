json.array!(@categories) do |category|
  json.extract! category, :id, :uuid, :name, :icon_prefix, :icon_suffix
  json.url category_url(category)
end
