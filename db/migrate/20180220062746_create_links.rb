class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
    	t.string :title
      t.string :url
      t.text :description
      t.references :user
      t.integer :points, default: 1
    	t.float :hot_score, default: 0

      t.timestamps
    end
  end
end
