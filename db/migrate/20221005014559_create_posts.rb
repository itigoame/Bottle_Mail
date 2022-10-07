class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table   :posts do |t|
      t.references :member,    null: false, foreign_key: true
      t.references :genre,     foreign_key: true
      t.string     :title,     null: false
      t.string     :body,      null: false
      t.boolean    :is_closed, null: false, default: false

      t.timestamps
    end
  end
end
