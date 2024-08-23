class Customer < ApplicationRecord
  has_many :subscriptions, dependent: :destroy

  validates_presence_of :first_name, :last_name, :address
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end