require "rails_helper"

RSpec.describe "PATCH /api/v1/customers/:customer_id/subscriptions/:id" do
  let!(:customer) { Customer.create(first_name: "Luis", last_name: "Aparicio", email: "Luis@email.com", address: "12907 conquistador loop dr, Tampa, Florida, 34610") }
  let!(:tea1) { Tea.create(title: "Black Tea", description: "bold and brisk", temperature: 212, brew_time: 3.5) }
  let!(:tea2) { Tea.create(title: "Green Tea", description: "grassy flavor", temperature: 175, brew_time: 2) }

  before(:each) do
    @headers = { "content-type": "application/json", "Accept": "application/json" }
    @subscription_body = { "teas": [tea1.id, tea2.id], "title": "Tea Subscription", "price": 20, "frequency": "monthly", "status": "active" }.to_json
    post "/api/v1/customers/#{customer.id}/subscriptions", headers: @headers, params: @subscription_body
  end

  it "can cancels a customer subscription" do
    cancel_body = { "status": "cancelled" }.to_json
    patch "/api/v1/customers/#{customer.id}/subscriptions/#{Subscription.last.id}", params: cancel_body, headers: @headers
    expect(response.status).to eq 200
    
    subscription = JSON.parse(response.body, symbolize_names: true)[:data]
    teas = JSON.parse(response.body, symbolize_names: true)[:data][:relationships][:teas][:data]
    expect(subscription[:type]).to eq "subscription"
    expect(teas).to be_an Array
    expect(teas.size).to eq 2
    expect(teas).to all(include("type": "tea"))

    attributes = subscription[:attributes]
    expect(attributes[:title]).to eq "Tea Subscription"
    expect(attributes[:price]).to eq 20
    expect(attributes[:frequency]).to eq "monthly"
    expect(attributes[:status]).to eq "cancelled"
  end

  it "requires valid customer id" do
    cancel_body = { "status": "cancelled" }.to_json
    patch "/api/v1/customers/0/subscriptions/#{Subscription.last.id}", params: cancel_body, headers: @headers
    expect(response.status).to eq 404
  end
end