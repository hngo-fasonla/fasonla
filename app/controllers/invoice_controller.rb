class InvoiceController < ApplicationController
  # Create Invoice, call by ajax
  def create
    fa_invoice = Invoice.new(params_invoices)
    if fa_invoice.save
      render json: true
    else
      render json: false
    end
  end
  
  private
    def params_invoices
      params.require(:invoices).permit(:order_id, :tax_code, :company_name, :address_company, :address_receiver, :receiver_name, :receiver_phone)
    end
end
