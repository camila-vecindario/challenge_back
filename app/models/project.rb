class Project < ApplicationRecord
  belongs_to  :user
  has_many    :price_histories, dependent:  :destroy
  belongs_to  :location
end
