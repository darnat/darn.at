class CreateJoinTableTechnologyTutorial < ActiveRecord::Migration[5.1]
  def change
    create_join_table :technologies, :tutorials do |t|
    	t.references :technology, index: true, null: false, foreign_key: { on_delete: :cascade }
    	t.references :tutorial, index: true, null: false, foreign_key: { on_delete: :cascade }
      	t.index [:technology_id, :tutorial_id]
      	t.index [:tutorial_id, :technology_id]
    end
  end
end
