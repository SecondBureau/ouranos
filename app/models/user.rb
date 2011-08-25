class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable, :confirmable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  belongs_to :role
  after_create :set_default_role
  
  def is_of_role? role_name
    return role.name == role_name.to_s
  end
  
  def self.guest
    if @guest == nil
      @guest = User.new
      @guest.role = Role.where("name = ?", "guest").first
    end
    @guest
  end
  
  private 
    def set_default_role
      role = Role.where("name = ?", "user") if !role
      save
    end
  
end
