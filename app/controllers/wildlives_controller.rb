class WildlivesController < ApplicationController
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
        if exact_math?(wildlife)
            render json: { erors: ['Common name and Scientific Binomial cannot be the same.']}
        elsif wildlife.valid?
            render json: wildlife
        else
            render json: { errors: wildlife.errors.full_messages}, status: :unprocessable_entity
        end
    end
    def update
        wildlife = Wildlife.find(params[:id])
        wildlife.update(wildlife_params)
        if wildlife.valid?
            render json: wildlife
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
end
