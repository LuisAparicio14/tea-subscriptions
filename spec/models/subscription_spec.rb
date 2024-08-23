require "rails_helper"

RSpec.describe Subscription, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:frequency) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:customer_id) }


    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should define_enum_for(:status).with_values(active: 0, cancelled: 1) }
  end

  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :tea_subscriptions }
    it { should have_many(:teas).through(:tea_subscriptions) }
  end
end