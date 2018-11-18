class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.string :request_id
      t.text :notes
      t.datetime :timestamp

      t.timestamps
    end
  end
end
