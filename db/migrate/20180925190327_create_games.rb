class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.references :p1, foreign_key: true
      t.references :p2, foreign_key: true
      t.references :p3, foreign_key: true
      t.references :p4, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
