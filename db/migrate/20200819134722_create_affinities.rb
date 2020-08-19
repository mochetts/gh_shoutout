class CreateAffinities < ActiveRecord::Migration[6.0]
  def change
    create_table :affinities do |t|
      t.date :date
      t.integer :strength
      t.integer :interactions_count
      t.string :user1
      t.string :user2

      t.timestamps
    end
  end
end
