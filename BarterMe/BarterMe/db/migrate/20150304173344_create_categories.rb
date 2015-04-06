class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.integer :similar_category
      t.integer :item_id

      t.timestamps
    end
    remove_columns(:categories, :similar_category, :item_id)
  end
end
