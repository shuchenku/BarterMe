class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :user_name
      t.string :email
      t.string :phone
      t.integer :reliability

      t.timestamps
    end
  end
end
