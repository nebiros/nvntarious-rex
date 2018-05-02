require "csv"

def set_default_admin
  User.delete_all
  User.new(email: "admin@example.com", password: "admin123").save
end

def get_csv(filename)
  csv_text = File.read(Rails.root.join("lib", "seeds", filename))
  csv = CSV.parse(csv_text, headers: true, col_sep: ";", encoding: "UTF-8")
  csv
end

# @return [void]
def add_initial_inventory
  Product.delete_all
  Item.delete_all

  csv = get_csv("inventario.csv")
  csv.each do |row|
    p = Product.new
    p.name = row.field(0).to_s
    p.save

    i = Item.new
    i.product = p
    i.item_type = Item::TYPE.index("compra").to_i
    i.quantity = row.field(1).to_i
    i.cost = row.field(3).to_i
    i.save
  end
end

# @return [void]
def add_purchases
  csv = get_csv("compras.csv")
  csv.each do |row|
    p = Product.find_by(name: row.field(0).to_s)

    next if p.nil?

    i = Item.new
    i.product = p
    i.item_type = Item::TYPE.index("compra").to_i
    i.quantity = row.field(1).to_i
    i.cost = row.field(2).to_i
    i.save
  end
end

def add_sales
  csv = get_csv("ventas.csv")
  csv.each do |row|
    p = Product.find_by(name: row.field(0).to_s)

    next if p.nil?

    i = Item.new
    i.product = p
    i.item_type = Item::TYPE.index("venta").to_i
    i.quantity = row.field(1).to_i
    i.cost = row.field(2).to_i
    i.save
  end
end

set_default_admin
add_initial_inventory
add_purchases
add_sales