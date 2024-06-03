# frozen_string_literal: true

# Serializer for the User model.
class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name, :role
end
