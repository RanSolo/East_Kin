json.array!(@songs) do |song|
  json.extract! song, :id, :lyric, :title, :writers, :copyright, :active
  json.url song_url(song, format: :json)
end
