require 'rails_helper'

describe 'Product API', type: :request do
  describe '#index' do
    let!(:product_1) { create(:product, item_name: "A", price: 30.0) }
    let!(:product_2) { create(:product, item_name: "B", price: 20.0) }
    let!(:product_3) { create(:product, item_name: "C", price: 50.0) }
    before do
      get "/ecommerce_service/api/v1/products"
    end
    it 'should return status code 200' do
      expect(response).to have_http_status(200)
    end
    it 'should return all products' do
      expect(json).not_to be_empty
      expect(json.count).to eq(3)
      expect(json).to eq(serializer_helper(V1::ProductSerializer.new([product_1, product_2, product_3]).data))
    end
  end

  describe '#create' do
    let!(:valid_params) { build(:product).attributes }
    before do
      post "/ecommerce_service/api/v1/products", params: { product: valid_params }
    end
    it 'should return status code 201' do
      expect(response).to have_http_status(201)
    end
    it 'should return create product' do
      expect(json).not_to be_empty
      expect(json).to be_a(Hash)
      expect(json["price"]).to eq(valid_params["price"])
      expect(json["description"]).to eq(valid_params["description"])
      expect(json["item_name"]).to eq(valid_params["item_name"])
    end
  end

  describe '#update' do
    let!(:product) { create(:product, item_name: "A", price: 30.0) }
    let!(:valid_params) { { product: { price: 50 }} }
    before do
      put "/ecommerce_service/api/v1/products/#{product.id}", params: valid_params
    end
    it 'should return status code 200' do
      expect(response).to have_http_status(200)
    end
    it 'should return create product' do
      expect(json).not_to be_empty
      expect(json).to be_a(Hash)
      expect(json["price"]).to eq(50)
    end
  end

  describe '#show' do
    let!(:product) { create(:product, item_name: "D", price: 50.0) }
    before do
      get "/ecommerce_service/api/v1/products/#{product.id}"
    end
    it 'should return status code 200' do
      expect(response).to have_http_status(200)
    end
    it 'should return create product' do
      expect(json).not_to be_empty
      expect(json).to be_a(Hash)
      expect(json).to eq(serializer_helper(V1::ProductSerializer.new(product).data))
    end
  end
end
