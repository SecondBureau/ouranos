class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable, :confirmable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  belongs_to :role
  has_many :subscribes
  has_many :comments, :as => :commentable
  has_one :member_confirm
  
  validates_presence_of :firstname, :lastname
  
  def is_of_role? role_name
    be_user if !self.role
    if self.role.name == :member && self.expiry_date < Time.now
      be_user
    end
    return role.name == role_name.to_s
  end
  
  private
    def be_user
      self.role = Role.where("name = ?", "user").first
      save
    end
  
end
