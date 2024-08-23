class Api::V1::SubscriptionsController < ApplicationController
  def create
    subs = Subscription.new(subscription_params)
    if subs.save!
      params[:teas].each do |tea_id|
        TeaSubscription.create!(tea_id: tea_id, subscription_id: subs.id)
      end

      render json: SubscriptionSerializer.new(subs), status: :created
    end
  end

  def update
    subs = Subscription.find(params[:id])
    subs.update!(subscription_params)
    render json: SubscriptionSerializer.new(subs), status: :ok
  end

  def index
    customer = Customer.find(params[:customer_id])
    subs = customer.subscriptions
    render json: SubscriptionSerializer.new(subs)
  end
  private
  def subscription_params
    params.permit(:title, :price, :frequency, :status, :customer_id)
  end
end