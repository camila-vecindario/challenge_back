class UserSerializer < ActiveModel::Serializer
  attributes :id, :fullName, :email, :phone, :created_at

  def fullName
    "#{object.first_name} #{object.last_name}"
  end
end
