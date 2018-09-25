class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :email, index: true
      t.timestamps
    end
    create_table :games do |t|
      t.integer :p1_id, foreign_key: true, index: true
      t.integer :p2_id, foreign_key: true, index: true
      t.integer :p3_id, foreign_key: true, index: true
      t.integer :p4_id, foreign_key: true, index: true
      t.string :name, index: true
      t.timestamps
    end
    create_table :rounds do |t|
      t.references :game, foreign_key: true, index: true
      t.integer :s1
      t.integer :s2
      t.integer :s3
      t.integer :s4
      t.integer :roundtype
      t.timestamps
    end
  end
end
