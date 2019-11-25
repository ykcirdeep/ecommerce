class V1::CheckoutSerializer < ActiveModel::Serializer
  attr_accessor :products, :total_amount, :amount
  attributes :data
  def initialize(products)
    @products = products
    @amount = 0
    @total_amount = 0
  end

  def data
    return detail(products) if products.is_a? Product
    details = products.map do |product|
      detail(product)
    end
    additional_discount
    {
      products: details,
      total_amount: @total_amount,
      additional_discount: @amount - @total_amount
    }
  end

  def additional_discount
    if @amount > 150
      @total_amount = @amount - 20
    else
      @total_amount = @amount
    end
  end

  private

  def detail(product)
    @amount += product.price.to_f
    {
      id: product.id,
      price: product.price.to_f,
      discount: product.discount.to_f
    }
  end
end
