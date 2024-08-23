class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :tea_subscriptions, dependent: :destroy
  has_many :teas, through: :tea_subscriptions

  validates_presence_of :title, :price, :frequency, :status, :customer_id
  validates :price, numericality: { greater_than: 0 }

  enum status: { active: 0, cancelled: 1 }
end