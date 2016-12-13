class AddAddressToClubEvent < ActiveRecord::Migration
  def change
    add_column :club_events, :address, :string
  end
end
