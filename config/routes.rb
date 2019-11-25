Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :user
  scope :ecommerce_service, defaults: { format: :json } do
    scope :api do
      namespace :v1 do
        mount_devise_token_auth_for 'User', at: 'auth'
        resources :products do
          resources :discounts, only: [ :create, :update ]
        end
        resources :checkout
      end
    end
  end
end
