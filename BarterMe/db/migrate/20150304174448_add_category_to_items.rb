class AddCategoryToItems < ActiveRecord::Migration
  def change
    add_column :items, :category1, :integer
    add_column :items, :category2, :integer
    add_column :items, :category3, :integer
  end
end
