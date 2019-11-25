class V1::ProductsController < ApplicationController

  def index
    products = Product.all
    render json: Oj.dump(V1::ProductSerializer.new(products).data, mode: :compat), status: :ok
  end

  def create
    product = Product.new(product_params)
    if product.save
        render json: Oj.dump(V1::ProductSerializer.new(product).data, mode: :compat), status: :created
    else
      render json: product.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if product_detail.update(product_update_params)
      render json: Oj.dump(V1::ProductSerializer.new(product_detail).data, mode: :compat), status: :ok
    else
      render json: product.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if product_detail.destroy
      render json: { message: "Product is remove" }, status: :ok
    else
      render json: product_detail.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render json: Oj.dump(V1::ProductSerializer.new(product_detail).data, mode: :compat), status: :ok
  end

  private

  def product_params
    params.require(:product).permit(:item_name, :price, :image, :description)
  end

  def product_update_params
    params.require(:product).permit(:id, :item_name, :price, :image, :description)
  end

  def product_detail
    @product ||= Product.find(params[:id])
  end
end
