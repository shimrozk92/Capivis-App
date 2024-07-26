# frozen_string_literal: true

# Serializer for the User model.
class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :first_name,:last_name, :ssn_id, :role, :phone_number, :city, :state, :country, :address_line_1, :birthdate, :photo, :profileable_id, :profileable_type
end
