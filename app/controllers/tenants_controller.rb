class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_not_valid
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update!(tenant_params)
        render json: tenant
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        head :no_content
    end
    private

    def tenant_params
        params.permit(:name, :age)
    end

    def render_not_valid(invalid)
        render json: {errors: invalid.record.errors }, status: :unprocessable_entity
    end

    def render_not_found
        render json: {error: "Tenant not found"}, status: :not_found
    end

end
