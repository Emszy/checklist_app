class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :name
      t.date :date
      t.text :note
      t.boolean :done

      t.timestamps
    end
  end
end
