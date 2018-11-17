class CreateLimits < ActiveRecord::Migration[5.0]
  def change
    create_table :limits do |t|
      t.string :classification
      t.integer "Very High".to_sym
      t.integer :High
      t.integer :Normal
      t.integer :Low
      t.integer "Very Low".to_sym

      t.timestamps
    end
  end
end