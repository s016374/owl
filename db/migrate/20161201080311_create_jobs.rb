class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.belongs_to :user

      t.string "title"
      t.string "job_type"
      t.string "occupation"
      t.string "company_name"
      t.string "location"
      t.string "url"
      t.text "description"
      t.text "apply_information"
      t.date "deadline"

      t.timestamps
    end
  end
end
