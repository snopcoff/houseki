class CreateClubEventsUsers < ActiveRecord::Migration
  def change
    create_table :club_events_users, id: false do |t|
      t.integer :club_event_id
      t.integer :user_id
    end
  end
end
