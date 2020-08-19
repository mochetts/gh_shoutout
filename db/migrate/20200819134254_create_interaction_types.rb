class CreateInteractionTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :interaction_types do |t|
      t.string :name
      t.integer :weight

      t.timestamps
    end
  end
end
