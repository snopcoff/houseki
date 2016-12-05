class CreateClubEvents < ActiveRecord::Migration
  def change
    create_table :club_events do |t|
      t.integer :club_id
      t.integer :user_id
      t.string :name
      t.text :description
      t.datetime :from_date
      t.datetime :to_date

      t.timestamps null: false
    end
  end
end
