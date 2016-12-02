class Club < ActiveRecord::Base
    has_many :club_members
    has_many :users, :through => :club_members
    accepts_nested_attributes_for :club_members,
                :allow_destroy => true
    accepts_nested_attributes_for :users
    validates :name, presence: true
end
