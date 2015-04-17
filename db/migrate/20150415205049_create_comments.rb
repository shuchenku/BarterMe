class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :from
      t.text :message
      t.integer :offer_id
    end
  end
end
