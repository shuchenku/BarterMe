class CreateOffersUsers < ActiveRecord::Migration
  def change
    create_table :offers_users do |t|
    	t.belongs_to :offers
    	t.belongs_to :users
    end
  end
end
