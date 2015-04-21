class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :user_name
      t.string :password
      t.string :email
      t.string :phone
      t.integer :reliability
      t.text :looking_for

      t.timestamps
    end
    add_column :users, :admin, :boolean
    remove_columns(:users, :user_id)
  end
end
