class Tea < ApplicationRecord
  has_many :tea_subscriptions
  has_many :subscriptions, through: :tea_subscriptions

  validates_presence_of :title, :description
  validates :temperature, presence: true, numericality: { greater_than: 0 }
  validates :brew_time, presence: true, numericality: { greater_than: 0 }
end