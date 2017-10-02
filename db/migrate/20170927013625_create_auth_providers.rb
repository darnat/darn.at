class CreateAuthProviders < ActiveRecord::Migration[5.1]
  def change
    create_table :auth_providers do |t|
      t.string :name
      t.string :uid
      t.references :user, index: true, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :auth_providers, [:name, :user_id],   unique: true
    add_index :auth_providers, [:name, :uid],   unique: true
  end
end
