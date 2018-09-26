class CreateTables < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp'
    create_table :games, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.string :owner
      t.string :player1, null: false
      t.string :player2, null: false
      t.string :player3, null: false
      t.string :player4, null: false
      t.string :name, index: true
      t.timestamps
    end
    create_table :rounds do |t|
      t.uuid :game_id, index: true
      t.integer :score1
      t.integer :score2
      t.integer :score3
      t.integer :score4
      t.integer :roundtype
      t.timestamps
    end
    add_foreign_key :rounds, :games, on_delete: :cascade
  end
end
