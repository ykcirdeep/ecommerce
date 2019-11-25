class V1::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  # protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
  include Error::ErrorHandler
  before_action :authenticate_user!
end
