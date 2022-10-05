class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name,         null: false

      t.timestamps
    end
  end
end
