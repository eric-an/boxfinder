json.array!(@shipments) do |shipment|
  json.extract! shipment, :id, :length, :width, :height, :weight
  json.url shipment_url(shipment, format: :json)
end
