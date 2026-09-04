class SupportCasesController < ApplicationController
  def index
    @support_cases = authorized_scope(SupportCase.all).includes(:customer).order(opened_at: :desc)
  end

  def show
    @support_case = authorized_scope(SupportCase.all).find(params[:id])
  end
end
