class UsersSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :api_key
end
