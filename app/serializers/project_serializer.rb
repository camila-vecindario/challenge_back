class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :type_project, :sales_room_emails
end
