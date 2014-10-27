class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :order_id
      t.string :tax_code
      t.string :company_name
      t.string :address_company
      t.string :address_receiver
      t.string :receiver_name
      t.string :receiver_phone

      t.timestamps
    end
  end
end
