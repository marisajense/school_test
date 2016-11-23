class CreateKindergartens < ActiveRecord::Migration[5.0]
  def change
    create_table :kindergartens do |t|
      t.string :name, null: false
      t.integer :students
      t.boolean :open

      t.timestamps
    end
  end
end
