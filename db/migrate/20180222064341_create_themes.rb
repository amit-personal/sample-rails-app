class CreateThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :themes do |t|
    	t.string :name
    	t.string :header_colour
    	t.string :body_colour
    	t.boolean :selected, default: false
    	
      t.timestamps
    end
  end
end
