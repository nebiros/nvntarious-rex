json.extract! item, :id, :product_id, :type, :quantity, :cost, :price, :created_at, :updated_at
json.url item_url(item, format: :json)
