class FraudAddressDataController < ApplicationController
  def index
    @fraud_address_data = FraudAddressData.all
    render json: { fraud_address_data: @fraud_address_data }, status: :ok
  end
end
