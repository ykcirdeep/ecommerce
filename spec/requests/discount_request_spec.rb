require 'rails_helper'

describe 'Discount API', type: :request do

  describe '#create' do
    let!(:product) { create(:product, item_name: "A", price: 30.0) }
    let!(:valid_params) { build(:discount).attributes }
    before do
      post "/ecommerce_service/api/v1/products/#{product.id}/discounts", params: { discount: valid_params }
    end
    it 'should return status code 201' do
      expect(response).to have_http_status(201)
    end
    it 'should return create product' do
      expect(json).not_to be_empty
      expect(json).to be_a(Hash)
      expect(json["message"]).to match(/Discount added for #{product.item_name}/)
    end
  end

  describe '#update' do
    let!(:product) { create(:product, item_name: "A", price: 30.0) }
    let!(:discount) { create(:discount, product_id: product.id, discount_value: 5)}
    let!(:valid_params) { { discount: { discount_type: 1, discount_value: 10 }} }
    before do
      put "/ecommerce_service/api/v1/products/#{product.id}/discounts/#{discount.id}", params: valid_params, as: :json
    end
    it 'should return status code 200' do
      expect(response).to have_http_status(200)
    end
    it 'should return create product' do
      expect(json).not_to be_empty
      expect(json).to be_a(Hash)
      expect(json["discount_type"]).to eq("percentage")
      expect(json["discount_value"].to_i).to eq(10)
    end
  end
end
