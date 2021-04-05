class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_one_attached  :picture
  has_many  :project_accesses
  has_many  :projects, through: :project_accesses, source: :project
  has_many  :project_leads
  has_many  :leads, through: :project_leads, source: :project

  def isAdmin
    return self.has_role? :admin
  end

  def own_projects
    return self.projects
  end
end
