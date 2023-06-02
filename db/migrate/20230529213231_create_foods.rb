class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.string :measurement_unit, null: false
      t.decimal :price
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
