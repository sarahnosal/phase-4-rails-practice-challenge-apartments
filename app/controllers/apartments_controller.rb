class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_not_valid
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def index
        apartments = Apartment.all
        render json: apartments
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update!(apartment_params)
        render json: apartment
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def render_not_valid(invalid)
        render json: {errors: invalid.record.errors }, status: :unprocessable_entity
    end

    def render_not_found
        render json: {error: "Apartment not found"}, status: :not_found
    end

    
end
