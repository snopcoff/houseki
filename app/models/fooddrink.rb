class Fooddrink < ActiveRecord::Base
    mount_uploader :file, FooddrinkUploader
    
    belongs_to :user
    belongs_to :fd_type
    
    validates :user, presence: true
    validates :name, presence: true
    acts_as_commontable
    
    ratyrate_rateable 'overall'
    
    resourcify
    
    def self.update_avg_qty(fooddrink)
        rates = Rate.where(:rateable_id => fooddrink.id)
        avg = rates.average(:stars).to_f
        qty = rates.count
        fooddrink.update_attributes(:avg => avg, :qty => qty)
    end
end
