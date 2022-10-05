class CreateEmpathies < ActiveRecord::Migration[6.1]
  def change
    create_table :empathies do |t|
      t.references :member, null: false, foreign_key: true
      t.references :post,   null: false, foreign_key: true

      t.timestamps
    end
  end
end
