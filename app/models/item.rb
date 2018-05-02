class Item < ApplicationRecord
  TYPE = %w[compra venta].freeze

  belongs_to :product

  def self.inventory
    query = %{
      SELECT
      items.id,
      items.product_id,
      SUM(
        CASE
          WHEN items.item_type = 0 THEN items.quantity ELSE - items.quantity
        END
      ) AS quantity,
      items.cost
      FROM
      items
      INNER JOIN
      products
      ON
      items.product_id = products.id
      GROUP BY
      items.product_id
      ORDER BY items.product_id ASC;}.gsub(/\s+/, " ").strip
    result = find_by_sql(query)
    return result
  end

  def self.inventory_to_csv
    column_names = %w{product_id product_name quantity total_cost}

    CSV.generate(headers: true) do |csv|
      csv << column_names

      Item.inventory.each do |item|
        csv << [item.product_id, item.product.name, item.quantity, item.quantity * item.cost]
      end
    end
  end

  def self.inventory_to_csv
    column_names = %w{product_id product_name quantity total_cost}

    CSV.generate(headers: true) do |csv|
      csv << column_names

      Item.inventory.each do |item|
        csv << [item.product_id, item.product.name, item.quantity, item.quantity * item.cost]
      end
    end
  end

  def self.purchases_to_csv
    column_names = %w{product_id product_name quantity cost}

    CSV.generate(headers: true) do |csv|
      csv << column_names

      Item.all.where(item_type: Item::TYPE.index("compra").to_i).each do |item|
        csv << [item.product_id, item.product.name, item.quantity, item.cost]
      end
    end
  end

  def self.sales_to_csv
    column_names = %w{product_id product_name quantity price}

    CSV.generate(headers: true) do |csv|
      csv << column_names

      Item.all.where(item_type: Item::TYPE.index("venta").to_i).each do |item|
        csv << [item.product_id, item.product.name, item.quantity, item.cost]
      end
    end
  end
end
