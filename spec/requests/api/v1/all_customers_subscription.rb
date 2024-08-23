require "rails_helper"

RSpec.describe "GET /api/v1/customers/:customer_id/subscriptions" do
  let!(:customer) { Customer.create(first_name: "Luis", last_name: "Aparicio", email: "Luis@email.com", address: "12907 conquistador loop dr, Tampa, Florida, 34610") }
  let!(:tea1) { Tea.create(title: "Black Tea", description: "bold and brisk", temperature: 212, brew_time: 3.5) }
  let!(:tea2) { Tea.create(title: "Green Tea", description: "grassy flavor", temperature: 175, brew_time: 2) }
  let!(:tea3) { Tea.create(title: "Oolong Tea", description: "floral aroma", temperature: 185, brew_time: 5) }

  before(:each) do
    @headers = { "content-type": "application/json", "Accept": "application/json" }
    @subs_1 = { "teas": [tea1.id, tea2.id], "title": "Tea Subscription", "price": 20, "frequency": "monthly", "status": "active" }.to_json
    @subs_2 = { "teas": [tea3.id], "title": "Tea Sub", "price": 30, "frequency": "monthly", "status": "active" }.to_json
    @cancel_sub_3 = { "status": "cancelled" }.to_json
    post "/api/v1/customers/#{customer.id}/subscriptions", headers: @headers, params: @subs_1
    post "/api/v1/customers/#{customer.id}/subscriptions", headers: @headers, params: @subs_2
    patch "/api/v1/customers/#{customer.id}/subscriptions/#{Subscription.last.id}", params: @cancel_sub_3, headers: @headers
  end

  it "can get all subscriptions for a customer" do
    get "/api/v1/customers/#{customer.id}/subscriptions", headers: @headers
    expect(response.status).to eq 200

    subs = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(subs).to be_an Array
    expect(subs.size).to eq 2
    expect(subs).to all(include("type": "subscription"))
    expect(subs[0][:attributes][:status]).to eq "active"
    expect(subs[1][:attributes][:status]).to eq "cancelled"
  end
end