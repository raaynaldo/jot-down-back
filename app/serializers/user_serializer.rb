class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :full_name, :first_name, :last_name, :email, :picture
end
