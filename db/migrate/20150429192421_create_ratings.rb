class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :offer_id
      t.integer :user_id
      t.float :score
    end
  end
end
