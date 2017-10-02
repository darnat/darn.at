class CreateTechnologies < ActiveRecord::Migration[5.1]
  def change
    create_table :technologies do |t|
      t.string :title
      t.string :slug
      t.text :body

      t.timestamps
    end
  end
end
