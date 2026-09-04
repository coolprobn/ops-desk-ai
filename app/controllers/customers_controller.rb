class CustomersController < ApplicationController
  def index
    @customers = authorized_scope(Customer.all).order(:company)
  end

  def show
    @customer = authorized_scope(Customer.all).find(params[:id])
    @subscriptions = @customer.subscriptions.order(started_at: :desc)
    @invoices = @customer.invoices.order(issued_at: :desc)
    @support_cases = @customer.support_cases.order(opened_at: :desc)
  end
end
