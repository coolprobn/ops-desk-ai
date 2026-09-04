class InvoicesController < ApplicationController
  def index
    @invoices = authorized_scope(Invoice.all).includes(:customer).order(issued_at: :desc)
  end

  def show
    @invoice = authorized_scope(Invoice.all).find(params[:id])
  end
end
