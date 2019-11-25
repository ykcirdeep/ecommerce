require 'rails_helper'

describe 'Checkout API', type: :request do
  let!(:product_1) { create(:product, item_name: "A", price: 30.0) }
  let!(:discount_1) { create(:discount, product_id: product_1.id, discount_value: 5)}
  let!(:product_2) { create(:product, item_name: "B", price: 20.0) }
  let!(:discount_2) { create(:discount, product_id: product_2.id, discount_value: 2.5)}
  let!(:product_3) { create(:product, item_name: "C", price: 50.0) }
  let!(:product_4) { create(:product, item_name: "D", price: 15.0) }
  let!(:user) { create(:user) }
  before do
    test_user = { email: 'user@test.com', password: 'testuser' }
    @auth_tokens = auth_tokens_for_user(test_user)
  end
  # describe '#create' do
  #   let!(:valid_params) { { checkout: { product_id: product_1.id } }  }
  #   before do
  #     post "/ecommerce_service/api/v1/checkout", params: valid_params, headers: @auth_tokens, as: :json
  #   end
  #   it 'should return status code 201' do
  #     expect(response).to have_http_status(201)
  #   end
  #   it 'should return create product' do
  #     expect(json).not_to be_empty
  #     expect(json).to be_a(Hash)
  #     expect(json['cart_count']).to eq(1)
  #   end
  # end

  # describe '#update' do
  #   let!(:checkout) { create(:checkout, product_id: product_1.id, quantity: 1, price: 30, discount: 0, user_id: user.id)}
  #   let!(:checkout_1) { create(:checkout, product_id: product_2.id, quantity: 1, price: 20, discount: 0, user_id: user.id)}
  #   let!(:valid_params) { { checkout: { product_id: product_1.id }} }
  #   before do
  #     put "/ecommerce_service/api/v1/checkout/#{checkout.id}", params: valid_params, headers: @auth_tokens, as: :json
  #   end
  #   it 'should return status code 200' do
  #     expect(response).to have_http_status(200)
  #   end
  #   it 'should return create product' do
  #     expect(json).not_to be_empty
  #     expect(json).to be_a(Hash)
  #   end
  # end

  describe '#index' do
    context 'When A, B, C products in basket' do
      let!(:checkout) { create(:checkout, product_id: product_1.id, quantity: 1, price: 30, discount: 0, user_id: user.id)}
      let!(:checkout_1) { create(:checkout, product_id: product_2.id, quantity: 1, price: 20, discount: 0, user_id: user.id)}
      let!(:checkout_2) { create(:checkout, product_id: product_3.id, quantity: 1, price: 50, discount: 0, user_id: user.id)}
      before do
        get "/ecommerce_service/api/v1/checkout", headers: @auth_tokens
      end
      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'should return create product' do
        expect(json).not_to be_empty
        expect(json).to be_a(Hash)
        expect(json['total_amount'].to_f).to eq(100.0)
      end
    end
    context 'When A*3, B*2 products in basket' do
      let!(:checkout) { create(:checkout, product_id: product_1.id, quantity: 3, price: 30, discount: 0, user_id: user.id)}
      let!(:checkout_1) { create(:checkout, product_id: product_2.id, quantity: 2, price: 20, discount: 0, user_id: user.id)}
      before do
        get "/ecommerce_service/api/v1/checkout", headers: @auth_tokens
      end
      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'should return create product' do
        expect(json).not_to be_empty
        expect(json).to be_a(Hash)
        expect(json['total_amount'].to_f).to eq(110.0)
        expect(json['additional_discount'].to_f).to eq(0.0)
      end
    end
    context 'When A*3, B*2, C, D products in basket' do
      let!(:checkout) { create(:checkout, product_id: product_1.id, quantity: 3, price: 30, discount: 0, user_id: user.id)}
      let!(:checkout_1) { create(:checkout, product_id: product_2.id, quantity: 2, price: 20, discount: 0, user_id: user.id)}
      let!(:checkout_2) { create(:checkout, product_id: product_3.id, quantity: 1, price: 50, discount: 0, user_id: user.id)}
      let!(:checkout_3) { create(:checkout, product_id: product_4.id, quantity: 1, price: 15, discount: 0, user_id: user.id)}
      before do
        get "/ecommerce_service/api/v1/checkout", headers: @auth_tokens
      end
      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'should return create product' do
        expect(json).not_to be_empty
        expect(json).to be_a(Hash)
        expect(json['total_amount'].to_f).to eq(155.0)
        expect(json['additional_discount'].to_f).to eq(20.0)
      end
    end
    context 'When A*3, C, D products in basket' do
      let!(:checkout) { create(:checkout, product_id: product_1.id, quantity: 3, price: 30, discount: 0, user_id: user.id)}
      let!(:checkout_1) { create(:checkout, product_id: product_4.id, quantity: 1, price: 15, discount: 0, user_id: user.id)}
      let!(:checkout_2) { create(:checkout, product_id: product_3.id, quantity: 1, price: 50, discount: 0, user_id: user.id)}
      before do
        get "/ecommerce_service/api/v1/checkout", headers: @auth_tokens
      end
      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'should return create product' do
        expect(json).not_to be_empty
        expect(json).to be_a(Hash)
        expect(json['total_amount'].to_f).to eq(140.0)
        expect(json['additional_discount'].to_f).to eq(0.0)
      end
    end
  end
end
