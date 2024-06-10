require 'rails_helper'

RSpec.describe "FraudAddressData", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/fraud_address_data/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /search" do
    it "returns http success" do
      get "/fraud_address_data/search"
      expect(response).to have_http_status(:success)
    end
  end

end
