class AddApprovedStatusToLinks < ActiveRecord::Migration[5.1]
  def change
  	add_column :links, :approved_status ,:boolean , default: false
  end
end
