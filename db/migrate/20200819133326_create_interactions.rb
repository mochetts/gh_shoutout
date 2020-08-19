class CreateInteractions < ActiveRecord::Migration[6.0]
  def change
    create_table :interactions do |t|
      t.datetime :interacted_at
      t.string :source_user
      t.string :target_user
      t.references :interaction_type, foreign_key: true
      
      t.timestamps
    end
  end
end
