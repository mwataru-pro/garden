class RenameAdressColumnToCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :adress, :address
  end
end
