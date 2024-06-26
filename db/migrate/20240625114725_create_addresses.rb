class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string     :district,     null: false
      t.string     :address_from, null: false
      t.string     :address_to
      t.string     :name
      t.text       :explanation
      t.integer    :load_place
      t.references :sheet,  foreign_key: true
      t.references :course, foreign_key: true
      t.timestamps
    end
  end
end
