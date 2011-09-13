class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable, :confirmable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  belongs_to :role
  has_many :subscribes
  has_one :member_confirm
  
  def is_of_role? role_name
    self.role = Role.where("name = ?", "user").first if !self.role
    return role.name == role_name.to_s
  end
  
end
