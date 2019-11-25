class V1::CheckoutController < V1::BaseController

  def index
    render json: Oj.dump(V1::CheckoutSerializer.new(current_user.checkouts).data, mode: :compat), status: :ok
  end

  def create
    detail = current_user.checkouts.new(checkout_params)
    if detail.save
      render json: { message: "Product added to cart", cart_count: current_user.checkouts.size }, status: :created
    else
      render json: detail.errors.full_message, status: :unprocessable_entity
    end
  end

  def update
    if checkout_detail.update(checkout_params)
      render json: { message: "Product added to cart", cart_count: current_user.checkouts.size }, status: :ok
    else
      render json: checkout_detail.errors.full_message, status: :unprocessable_entity
    end
  end

  private

  def checkout_params
    quantity_increament
    params.require(:checkout).permit(:id, :product_id, :quantity)
  end

  def checkout_detail
    @checkout ||= Checkout.find(params[:id])
  end

  def quantity_increament
    if params[:action] == 'create'
      params[:checkout][:quantity] = 1
    else
      params[:checkout][:quantity] = checkout_detail.quantity + 1
    end
  end

end
