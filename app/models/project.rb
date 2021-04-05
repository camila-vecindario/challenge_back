class Project < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_name,
                  against: :name,
                  using: {
                    trigram: {
                      threshold: 0.1
                    }
                  }

  enum type_project: { residential: 0, commercial: 1, industrial: 2, lots: 3 }

  validates :name,  :uniqueness => true

  has_one_attached  :cover
  has_many    :price_histories, dependent:  :destroy
  belongs_to  :location
  has_many  :project_accesses
  has_many  :project_leads
  has_many  :allowed_users, through: :project_accesses, source: :user
  has_many  :leads, through: :project_leads, source: :user

  def price
    last_price = self.price_histories.last
    if (last_price)
      return last_price.value
    end
    return 0
  end
end
