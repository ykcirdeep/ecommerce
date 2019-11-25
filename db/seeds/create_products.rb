product_lists = [{ item_name: "A", price: 30, description: "This is a new Product. Value for money Product." },
  { item_name: "B", price: 20, description: "This is a new Product. Value for money Product." },
  { item_name: "C", price: 50, description: "This is a new Product. Value for money Product." },
  { item_name: "D", price: 15, description: "This is a new Product. Value for money Product." }]

product_lists.map do |prod|
  Product.create!(prod)
end
