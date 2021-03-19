class Project < ApplicationRecord
  enum type_project: { residential: 0, commercial: 1, industrial: 2, lots: 3 }

  validates :name,  :uniqueness => true

  has_one_attached  :cover
  has_many    :price_histories, dependent:  :destroy
  belongs_to  :location
  has_and_belongs_to_many :users
  has_and_belongs_to_many :project_leads, join_table: 'project_leads', class_name: 'User'
end
