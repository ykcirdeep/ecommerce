module AuthorizationHelper
  def sign_up(user)
    get '/ecommerce_service/api/v1/auth/', params: { email: user[:email], password: user[:password], password_confirmation: user[:password] }, as: :json
  end

  def auth_tokens_for_user(user)
    post '/ecommerce_service/api/v1/auth/sign_in',
      params: { email: user[:email], password: user[:password] },
      as: :json
    response.headers.slice('client', 'access-token', 'uid')
  end
end
