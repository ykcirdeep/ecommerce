class V1::DiscountsController < ApplicationController

  def create
    discount = product_detail.build_discount(discount_params)
    if discount.save
        render json: { message: "Discount added for #{product_detail.item_name}" }, status: :created
    else
      render json: discount.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if discount_detail.update(discount_params)
      render json: discount_detail, status: :ok
    else
      render json: discount_detail.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    if product_detail.destroy
      render json: { message: "Product is remove" }, status: :ok
    else
      render json: product_detail.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def discount_params
    params.require(:discount).permit(:id, :discount_type, :discount_value)
  end

  def discount_detail
    @discount ||= Discount.find(params[:id])
  end

  def product_detail
    @product ||= Product.find(params[:product_id])
  end
end
