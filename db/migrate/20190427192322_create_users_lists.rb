class CreateUsersLists < ActiveRecord::Migration[5.2]
  def change
    create_table :users_lists do |t|
      t.integer :list_id
      t.integer :user_id
      t.string :privilege
    end
  end
end
