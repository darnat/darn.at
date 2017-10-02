class CreateTutorials < ActiveRecord::Migration[5.1]
  def change
    create_table :tutorials do |t|
      t.string :title
      t.text :body
      t.string :slug
      t.references :user, index: true, null: false, foreign_key: { on_delete: :cascade }
      t.integer :published, limit: 1, default: -1

      t.timestamps
    end
    add_index :tutorials, :slug, unique: true
  end
end
