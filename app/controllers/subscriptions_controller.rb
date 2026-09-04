class SubscriptionsController < ApplicationController
  def index
    @subscriptions =
      authorized_scope(Subscription.all).includes(:customer).order(
        started_at: :desc
      )
  end

  def show
    @subscription = authorized_scope(Subscription.all).find(params[:id])
  end
end
