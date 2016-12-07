class CreateClubMembers < ActiveRecord::Migration
  def change
    create_table :club_members do |t|
      t.belongs_to :club, index: true
      t.belongs_to :user, index: true
      t.boolean :is_moderator, default: false

      t.timestamps null: false
    end
  end
end
