class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string     :name,              null: false
      t.text       :explanation
      t.boolean    :create_load_sheet, null: false, default: false
      t.references :sheet,             foreign_key: true
      t.timestamps
    end
  end
end
