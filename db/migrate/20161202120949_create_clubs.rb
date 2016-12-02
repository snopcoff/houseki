class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :club_avatar
      t.text :description
      t.integer :club_event_id

      t.timestamps null: false
    end
  end
end
