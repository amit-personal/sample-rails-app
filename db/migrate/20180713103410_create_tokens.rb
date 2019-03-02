class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.string :token
      t.datetime :expire_at
      t.references :user
      t.boolean :is_used, default: false
      t.string :type

      t.timestamps
    end
    add_index :tokens, [:type, :token, :expire_at, :is_used]
  end
end
