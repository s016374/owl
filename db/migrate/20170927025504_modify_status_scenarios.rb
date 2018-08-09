class ModifyStatusScenarios < ActiveRecord::Migration[5.0]
  def change
    change_column :scenarios, :status, :string
  end
end
