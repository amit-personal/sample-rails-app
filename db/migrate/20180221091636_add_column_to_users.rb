class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :mobile_no, :string
    add_index :users, :mobile_no, unique: true
  end
end
