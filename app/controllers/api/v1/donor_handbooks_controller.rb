module Api
	module V1
		class DonorHandbooksController < ApplicationController
			before_action :authenticate_user!
		  before_action :set_donor_handbook, only: [:show, :update, :destroy]
		  load_and_authorize_resource

		  # GET /api/v1/donor_handbooks
		  def index
		    @donor_handbooks = DonorHandbook.all

		    render json: @donor_handbooks
		  end

		  # GET /api/v1/donor_handbooks/:id
		  def show
		    render json: @donor_handbook
		  end

		  # POST /api/v1/donor_handbooks
		  def create
		    @donor_handbook = DonorHandbook.new(donor_handbook_params)

		    if @donor_handbook.save
		      render json: @donor_handbook, status: :created
		    else
		      render json: @donor_handbook.errors, status: :unprocessable_entity
		    end
		  end

		  # PATCH/PUT /api/v1/donor_handbooks/:id
		  def update
		    if @donor_handbook.update(donor_handbook_params)
		      render json: @donor_handbook
		    else
		      render json: @donor_handbook.errors, status: :unprocessable_entity
		    end
		  end

		  # DELETE /api/v1/donor_handbooks/:id
		  def destroy
		    @donor_handbook.destroy
		  end

		  private

		  def set_donor_handbook
		    @donor_handbook = DonorHandbook.find(params[:id])
		  end

		  def donor_handbook_params
		    params.require(:donor_handbooks).permit(:center_id, :description, :donor_id, questions: {}, responses: {})
		  end
		end
	end
end
