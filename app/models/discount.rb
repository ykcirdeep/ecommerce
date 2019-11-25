class Discount < ApplicationRecord
  belongs_to :product
  enum discount_type: [ :flat, :percentage ]
end
