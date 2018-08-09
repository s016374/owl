class ModifyStatusProjects < ActiveRecord::Migration[5.0]
  def change
    change_column :projects, :status, :string
  end
end
