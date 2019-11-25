class CreateCheckouts < ActiveRecord::Migration[5.2]
  def change
    create_table :checkouts do |t|
      t.belongs_to :product, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.integer :quantity, null: false, default: 1
      t.decimal :price
      t.decimal :discount

      t.timestamps
    end
  end
end
