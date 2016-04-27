json.array!(@bands) do |band|
  json.extract! band, :id, :name, :link, :link2
  json.url band_url(band, format: :json)
end
