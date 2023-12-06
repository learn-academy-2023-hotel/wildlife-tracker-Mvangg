class WildlivesController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        wildlives = Wildlife.all
        render json: wildlives
    end
    def show
        wildlife = Wildlife.find(params[:id])
        if wildlife.valid?
            render json: wildlife.to_json(include: :sightings)
        else
            render json: wildlife.errors
        end
    end
    def create
        wildlife = Wildlife.create(wildlife_params)
        if wildlife.valid?
            render json: wildlife
        elsif exact_math?(wildlife)
            render json: { erors: ['Common name and Scientific Binomial cannot be the same.']}
        else
            render json: wildlife.errors
        end
    end
    def update
        wildlife = Wildlife.find(params[:id])
        wildlife.update(wildlife_params)
        if wildlife.valid?
            render json: wildlife
        elsif exact_math?(wildlife)
            render json: { erors: ['Common name and Scientific Binomial cannot be the same.']}
        else
            render json: wildlife.errors
        end
    end
    def destroy
        wildlife = Wildlife.find(params[:id])
        if wildlife.destroy
            render json: wildlife
        else
            render json: wildlife.errors
        end
    end

    private
    def wildlife_params
        params.require(:wildlife).permit(:common_name, :scientific_binomial)
    end
    def exact_math?(wildlife)
        wildlife.common_name == wildlife.scientific_binomial
    end
    def render_unprocessable_entity_response(exception)
        render json: exception.record.errors, status: :unprocessable_entity
    end
    def render_not_found_response(exception)
        render json: { error: exception.message }, status: :not_found
    end
end
