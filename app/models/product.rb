class Product < ApplicationRecord
  has_one_attached :image
  has_one :discount
  has_many :checkouts
end
