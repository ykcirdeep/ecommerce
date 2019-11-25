class V1::ProductSerializer < ActiveModel::Serializer
  attr_accessor :products
  attributes :data
  def initialize(products)
    @products = products
  end

  def data
    return detail(products) if products.is_a? Product
    products.map do |product|
      detail(product)
    end
  end

  private
  def detail(product)
    {
      id: product.id,
      item_name: product.item_name,
      description: product.description,
      price: product.price.to_f,
      image: product.image
    }
  end
end
