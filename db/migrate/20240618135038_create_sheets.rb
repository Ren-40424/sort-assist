class CreateSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :sheets do |t|
      t.string :name, null: false
      t.text   :explanation
      t.timestamps
    end
  end
end
