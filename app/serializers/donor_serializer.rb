class DonorSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :ssn_id, :role, :phone_number, :city, :country, :birthdate, :address_line_1 
end
