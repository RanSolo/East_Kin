json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :link, :link2
  json.start event.start_time
  json.start_time event.start_time.strftime('%l:%M')
  json.end event.end_time
  json.url event_url(event, format: :html)
  json.name event.venue.name
end
