module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from StandardError do |exception|
          respond(:internal_server_error, 500, exception.to_s)
        end

        rescue_from ActiveRecord::RecordNotFound do |exception|
          respond(:record_not_found, 404, exception.to_s)
        end

        rescue_from ActiveRecord::RecordInvalid do |exception|
          respond(:record_not_found, 400, exception.to_s)
        end

        rescue_from ArgumentError do |exception|
          respond(:bad_request, 400, exception.to_s)
        end
      end
    end

    private

    def respond(error, status, message)
      render json: { status: status, error: error, message: message }, status: status
    end
  end
end
