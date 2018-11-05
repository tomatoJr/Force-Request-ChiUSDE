class AddAdminPriorityToStudentRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :student_requests, :admin_priority, :string
  end
end
