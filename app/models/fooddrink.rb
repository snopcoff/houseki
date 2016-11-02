class Fooddrink < ActiveRecord::Base
    mount_uploader :file, FooddrinkUploader
    
    belongs_to :user
    has_and_belongs_to_many :fd_types
    
    validates :user, presence: true
    acts_as_commontable
    
    resourcify
end
