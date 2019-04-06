class AddIsVerifiedToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :isVerified, :boolean
  end
end
