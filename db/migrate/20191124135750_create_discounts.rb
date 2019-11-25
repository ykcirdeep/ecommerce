class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.belongs_to :product, foreign_key: true
      t.integer :discount_type
      t.decimal :discount_value

      t.timestamps
    end
  end
end
