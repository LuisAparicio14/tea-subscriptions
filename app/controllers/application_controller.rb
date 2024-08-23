class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :error_message
  rescue_from ActiveRecord::RecordInvalid, with: :error_message

  def error_message(exception)
    if exception.message.include?("exist") || exception.message.include?("Couldn't find")
      render json: { errors: [{status: 404, details: exception.message }] }, status: :not_found
    else
      render json: { errors:[{ status: 400, detail: exception.message }] }, status: :bad_request
    end
  end
end
