class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :offer_id
      t.integer :user1_id
      t.integer :user2_id
      t.string :item1_id
      t.string :item2_id
      t.boolean :accepted

      t.timestamps
    end
    remove_column :offers, :offer_id
    add_column :offers, :pending, :boolean
  end
end
