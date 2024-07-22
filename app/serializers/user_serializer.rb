# frozen_string_literal: true

# Serializer for the User model.
class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :first_name,:last_name, :ssn_id, :role, :profileable_id, :profileable_type
end
