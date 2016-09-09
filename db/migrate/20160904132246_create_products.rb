class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.string :title
      t.text :image_url
      t.string :director
      t.text :detail
      t.string :open_date
      t.timestamps
    end
  end
end
