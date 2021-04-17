class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :fan, null: false, foreign_key: { table_to: :users }
      t.references :photo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
