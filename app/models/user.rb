class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]
  # after_create :assign_role
  mount_uploader :avatar, AvatarUploader
  
  has_many :fooddrinks, :dependent => :destroy
  acts_as_commontator
  
  ratyrate_rater
  
  has_many :club_members, :dependent => :destroy
  has_many :clubs, :through => :club_members
  has_many :club_events
  accepts_nested_attributes_for :club_members,
                :allow_destroy => true
  accepts_nested_attributes_for :clubs
         
  validates :name, presence: true
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.avatar = auth.info.image
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if(data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"])
        user.email = data["email"] if user.email.blank?
        user.avatar = data["image"]
      end
    end
  end
  
#  def assign_role
#    add_role(:member)
#  end
end
