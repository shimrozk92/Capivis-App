# spec/controllers/api/v1/donor/donors_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::DonorsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      donor = Donor.create!(
        email: "test@example.com",
        first_name: "John",
        last_name: "Doe",
        # Other attributes...
      )
      get :show, params: { id: donor.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new donor" do
        expect {
          post :create, params: { donor: valid_attributes }
        }.to change(Donor, :count).by(1)
      end

      it "renders a JSON response with the new donor" do
        post :create, params: { donor: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(api_v1_donor_donor_url(Donor.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new donor" do
        post :create, params: { donor: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { first_name: "New First Name" }
      }

      it "updates the requested donor" do
        donor = Donor.create!(valid_attributes)
        put :update, params: { id: donor.to_param, donor: new_attributes }
        donor.reload
        expect(donor.first_name).to eq("New First Name")
      end

      it "renders a JSON response with the donor" do
        donor = Donor.create!(valid_attributes)
        put :update, params: { id: donor.to_param, donor: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the donor" do
        donor = Donor.create!(valid_attributes)
        put :update, params: { id: donor.to_param, donor: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested donor" do
      donor = Donor.create!(valid_attributes)
      expect {
        delete :destroy, params: { id: donor.to_param }
      }.to change(Donor, :count).by(-1)
    end

    it "renders a JSON response with the donor" do
      donor = Donor.create!(valid_attributes)
      delete :destroy, params: { id: donor.to_param }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json')
    end
  end

  private

  def valid_attributes
  {
    email: "test@example.com",
    first_name: "John",
    last_name: "Doe",
    birthdate: Date.today,
    gender: "male",
    zipcode: "12345",
    phone_number: "123-456-7890",
    city: "Sample City",
    state: "Sample State",
    country: "Sample Country",
    language: "English"
    # Add other valid attributes as needed...
  }
end

  def invalid_attributes
    {
      email: nil, # Invalid attribute
      # Other invalid attributes...
    }
  end
end
