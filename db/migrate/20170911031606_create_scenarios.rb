class CreateScenarios < ActiveRecord::Migration[5.0]
  def change
    create_table :scenarios do |t|
      t.belongs_to :project

      t.string "title"
      t.string "url"
      t.string "headers"
      t.string "method"
      t.string "body"
      t.string "cookies"
      t.integer "active"
      t.integer "status"
      t.datetime "schedule"
      t.text "description"

      t.timestamps
    end
  end
end
