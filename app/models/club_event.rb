class DateTimeValidator < ActiveModel::Validator
  def validate(record)
    if record.from_date >= record.to_date
      record.errors[:base] << "Wrong date input"
    end
  end
end

class ClubEvent < ActiveRecord::Base
    belongs_to :club, polymorphic: true
    belongs_to :user
    
    validates_with DateTimeValidator
end