class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.integer :user_id, null: false
      t.integer :link_id, null: false
      t.integer :value, null: false
      t.timestamps
    end

    add_index :user_votes, :link_id
    add_index :user_votes, [:link_id, :user_id], uniqueness: true
  end
end
