require "rails_helper"

RSpec.describe Tea, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:temperature) }
    it { should validate_presence_of(:brew_time) }
    it { should validate_numericality_of(:temperature).is_greater_than(0) }
    it { should validate_numericality_of(:brew_time).is_greater_than(0) }
  end

  describe "relationships" do
    it { should have_many :tea_subscriptions }
    it { should have_many(:subscriptions).through(:tea_subscriptions) }
  end
end