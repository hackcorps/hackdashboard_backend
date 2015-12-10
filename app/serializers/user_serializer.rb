class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :role
  has_many :organizations
end
