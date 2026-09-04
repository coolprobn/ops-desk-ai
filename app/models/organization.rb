class Organization < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :customers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :support_cases, dependent: :destroy
  has_many :knowledge_documents, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
end
