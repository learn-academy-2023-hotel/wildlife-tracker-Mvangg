class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    # rescue_from ActiveRecord::RecordInvalid, with: render_unprocessable_entity_response
    # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response

    # def render_unprocessable_entity_response(exception)
    #     render json: exception.records.errors, status: :unprocessable_entity
    # end
    # def render_not_found_response(exception)
    #     render json: { error: exception.message }, status: :not_found
    # end
end
