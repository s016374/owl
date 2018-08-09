class ModifyColumnToProjects < ActiveRecord::Migration[5.0]
  def change
    change_column :projects, :schedule, :string
  end
end
