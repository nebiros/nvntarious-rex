class Item < ApplicationRecord
  TYPE = %w[compra venta].freeze

  belongs_to :product
end
