class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.belongs_to :user, index:true
      t.belongs_to :item, index:true
      
      t.integer :offer_id
      t.integer :user1_id
      t.integer :user2_id
      t.integer :item1_id
      t.integer :item2_id
      t.boolean :accepted

      t.timestamps
    end
  end
end
