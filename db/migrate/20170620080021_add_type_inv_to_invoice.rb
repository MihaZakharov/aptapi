class AddTypeInvToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :inv, :integer
  end
end
