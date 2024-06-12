class FraudAddressDataController < ApplicationController
  before_action :set_fraud_address_data, only: [:update, :destroy]

  def index
    @fraud_address_data = FraudAddressData.all
    render json: { fraud_address_data: @fraud_address_data }, status: :ok
  end

  def create
    @fraud_address_data = FraudAddressData.new(fraud_address_data_params)
    if @fraud_address_data.save
      render json: { success: true, message: 'Create successfully', fraud_address_data: @fraud_address_data}, status: :ok
    else
      render json: { success: false, error: 'could not create' }, status: :not_found
    end
  end

  def update
    if @fraud_address_data.update(fraud_address_data_params)
      render json: @fraud_address_data
    else
      render json: @fraud_address_data.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @fraud_address_data.destroy
    render json: { message: "fraud address data deleted successfully" }, status: :ok
  end


  private

  def set_fraud_address_data
    @fraud_address_data = FraudAddressData.find(params[:id])
  end

  def fraud_address_data_params
    params.permit(:address, :city, :state, :zip_code)
  end
end
