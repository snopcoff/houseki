class Club < ActiveRecord::Base
    mount_uploader :club_avatar, ClubAvatarUploader
    has_many :club_members, :dependent => :destroy
    has_many :users, :through => :club_members
    accepts_nested_attributes_for :club_members,
                :allow_destroy => true
    accepts_nested_attributes_for :users
    
    has_many :club_events
    accepts_nested_attributes_for :club_events
    validates :name, presence: true
end
