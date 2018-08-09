class AddExpectedBodyScenarios < ActiveRecord::Migration[5.0]
  def change
    add_column :scenarios, :expected_body, :string
  end
end
