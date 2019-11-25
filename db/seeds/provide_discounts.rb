product_a = Product.find_by(item_name: "A")
product_b = Product.find_by(item_name: "B")
discount_list = [ { product_id: product_a.id, discount_type: 0, discount_value: 5 }, { product_id: product_b.id, discount_type: 0, discount_value: 2.5 } ]

discount_list.each do |dis|
  Discount.create!(dis)
end
