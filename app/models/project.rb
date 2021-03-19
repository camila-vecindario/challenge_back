class Project < ApplicationRecord
  has_one_attached  :cover
  has_many    :price_histories, dependent:  :destroy
  belongs_to  :location
  has_and_belongs_to_many :users
  has_and_belongs_to_many :project_leads, join_table: 'project_leads', class_name: 'User'
end
