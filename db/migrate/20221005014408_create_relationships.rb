class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false

      t.timestamps

      t.index [:follower_id, :followed_id], unique: true

    end
  end
end
