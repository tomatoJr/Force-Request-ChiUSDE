class CreateLimits < ActiveRecord::Migration[5.0]
  def change
    create_table :limits do |t|
      t.string :classification
      t.integer :very_high
      t.integer :high
      t.integer :normal
      t.integer :low
      t.integer :very_low

      t.timestamps
    end
  end
end
