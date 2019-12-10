json.array!(@boxes) do |box|
  json.extract! box, :id, :length, :width, :height, :weight
  json.url box_url(box, format: :json)
end
