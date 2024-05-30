class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :first_name, :last_name, :middle_name, :birthdate, :gender,
             :zipcode, :phone_number, :alternate_phone_number, :city, :state, :country,
             :arrival_datetime, :address_line_1, :address_line_2, :language, :document
end
