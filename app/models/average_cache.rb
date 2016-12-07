class AverageCache < ActiveRecord::Base
  belongs_to :rater, :class_name => "User"
  belongs_to :rateable, :polymorphic => true
  
  def update_rate_average(stars, dimension=nil)
    if average(dimension).nil?
      send("create_#{average_assoc_name(dimension)}!", { avg: stars, qty: 1, dimension: dimension })
    else
      a = average(dimension)
      a.qty = rates(dimension).count
      a.avg = rates(dimension).average(:stars).round(3)
      a.save!(validate: false)
    end
  end
  
  def calculate_overall_average
    rating = Rate.where(rateable: self).pluck('stars')
    (rating.reduce(:+).to_f / rating.size).round(1)
  end
end
