require "csv"

User.new(email: "admin@example.com", password: "admin123").save

csv_text = File.read(Rails.root.join("lib", "seeds", "inventario.csv"))
csv = CSV.parse(csv_text, headers: true, col_sep: ";", encoding: "UTF-8")
csv.each do |row|
  p = Product.new
  p.name = row.field(0).to_s
  p.save

  i = Item.new
  i.product = p
  i.item_type = Item::TYPE[0].to_i
  i.quantity = row.field(1).to_i
  i.cost = row.field(3).to_i
  i.save
end
