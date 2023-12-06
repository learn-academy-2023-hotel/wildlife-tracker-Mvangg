class SightingsController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
 
 
    def index
        sightings = Sighting.where(date: date_params[:start_date]..params[:end_date])
        render json: sightings
    end
    def show
        sighting = Sighting.find_by(id: params[:id])
        if sighting
          render json: sighting, include: { wildlife: { only: [:common_name, :scientific_binomial] } }
        else
          render json: { message: 'No sighting found' }
        end
    end
    def create
        sighting = Sighting.create(sighting_params)
        if sighting.valid?
            render json: sighting
        else
            render json: sighting.errors
        end
    end
    def update
        sighting = Sighting.find(params[:id])
        sighting.update(sighting_params)
        if sighting.valid?
            render json: sighting
        else
            render json: sighting.errors
        end
    end
    def destroy
        sighting = Sighting.find(params[:id])
        if sighting.destroy
            render json: sighting
        else
            render json: sighting.errors
        end
    end


    private
    def sighting_params
        params.require(:sighting).permit(:wildlife_id, :latitude, :longitude, :date)
    end
    def date_params
        params.permit(:start_date, :end_date)
    end
    def render_unprocessable_entity_response(exception)
        render json: exception.record.errors, status: :unprocessable_entity
    end
    def render_not_found_response(exception)
        render json: { error: exception.message }, status: :not_found
    end
end
