class Checkout < ApplicationRecord
  belongs_to :product
  belongs_to :user
  before_save :add_discount

  def add_discount
    discount = product.discount
    discount.present? && discount.flat? ? flat_discount(discount) : percentage_discount(discount)
  end

  private

  def flat_discount(discount)
    if quantity > 1
      self.discount = discount.discount_value * quantity
      self.price = product.price * quantity - self.discount
    end
  end

  def percentage_discount(discount)
    if quantity > 1
      self.discount = (( product.price * discount.discount_value)/100 ) * quantity
      self.price = product.price * quantity - self.discount
    end
  end
end
