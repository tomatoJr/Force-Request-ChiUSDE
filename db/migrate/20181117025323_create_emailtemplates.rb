class CreateEmailtemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :emailtemplates do |t|
      t.text :body

      t.timestamps
    end
  end
end
