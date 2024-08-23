require "rails_helper"

RSpec.describe "POST /api/v1/customers/:customer_id/subscriptions" do
  let!(:customer) { Customer.create(first_name: "Luis", last_name: "Aparicio", email: "Luis@email.com", address: "12907 conquistador loop dr, Tampa, Florida, 34610") }
  let!(:tea1) { Tea.create(title: "Black Tea", description: "bold and brisk", temperature: 212, brew_time: 3.5) }
  let!(:tea2) { Tea.create(title: "Green Tea", description: "grassy flavor", temperature: 175, brew_time: 2) }

  it "can create a subscription for a customer" do
    headers = { "content-type": "application/json", "Accept": "application/json" }

    body = {
      "teas": [tea1.id, tea2.id],
      "title": "Tea Subscription",
      "price": 20,
      "frequency": "monthly",
      "status": "active"
    }.to_json

    post "/api/v1/customers/#{customer.id}/subscriptions", headers: headers, params: body
    expect(response.status).to eq(201)

    subs = JSON.parse(response.body, symbolize_names: true)[:data]
    teas = subs[:relationships][:teas][:data]

    expect(subs[:type]).to eq "subscription"
    expect(teas).to be_an Array
    expect(teas.size).to eq 2
    expect(teas).to all(include("type": "tea"))

    attributes = subs[:attributes]
    expect(attributes[:title]).to eq "Tea Subscription"
    expect(attributes[:price]).to eq 20
    expect(attributes[:frequency]).to eq "monthly"
    expect(attributes[:status]).to eq "active"
  end

  it "requires valid customer id" do
    headers = {"Content_Type": "application/json", "Accept": "application/json"}
    body = {
      "teas": [tea1.id, tea2.id],
      "title": "Tea Subscription",
      "price": 20,
      "frequency": "monthly",
      "status": "active"
    }

    post "/api/v1/customers/0/subscriptions", params: body, headers: headers
    expect(response.status).to eq 404
  end

  it "requires valid tea id's" do
    headers = {"Content_Type": "application/json", "Accept": "application/json"}
    body = {
      "teas": [0],
      "title": "Tea Subscription",
      "price": 20,
      "frequency": "monthly",
      "status": "active"
    }

    post "/api/v1/customers/#{customer.id}/subscriptions", params: body, headers: headers
    expect(response.status).to eq 404
  end

  it "requires valid subscription data" do
    headers = {"Content_Type": "application/json", "Accept": "application/json"}
    body = {
      "teas": [tea1.id, tea2.id],
      "title": "",
      "price": "",
      "frequency": "",
      "status": ""
    }

    post "/api/v1/customers/#{customer.id}/subscriptions", params: body, headers: headers
    expect(response.status).to eq 400
  end
end