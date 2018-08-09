class AddExpectedStatusScenarios < ActiveRecord::Migration[5.0]
  def change
    add_column :scenarios, :expected_status, :string
  end
end
