class DashboardsController < ApplicationController
  def show
    @customer_count = authorized_scope(Customer.all).count
    @open_cases_count = authorized_scope(SupportCase.all).open.count
    @past_due_subscriptions_count =
      authorized_scope(Subscription.all).past_due.count
    @unpaid_invoices_count = authorized_scope(Invoice.all).issued.count
    @recent_cases =
      authorized_scope(SupportCase.all)
        .includes(:customer)
        .order(opened_at: :desc)
        .limit(8)
    @customers = authorized_scope(Customer.all).order(:company).limit(8)
  end
end
