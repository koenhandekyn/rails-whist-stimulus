class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.references :game, foreign_key: true
      t.integer :s1
      t.integer :s2
      t.integer :s3
      t.integer :s4
      t.integer :roundtype

      t.timestamps
    end
  end
end
