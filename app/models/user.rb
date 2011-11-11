class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable, :confirmable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :expiry_date, :role_id, :is_expiried
  
  belongs_to :role
  has_many :subscribes
  has_many :comments, :as => :commentable
  has_one :member_confirm
  has_one :family
  
  after_create :send_membership_email
  before_save :set_is_expiried
  
  def is_of_role? role_name
    return false if !self.role
    if self.role.name == :member && self.expiry_date < Time.now
      be_user
    end
    return role.name == role_name.to_s
  end
  
  def to_s
    "#{email}"
  end
  
  private
    def be_user
      self.role = Role.where("name = ?", "member").first
      save
    end
    
    def send_membership_email
      if Setting.first.send_email_after_user_created
        token = SecureRandom.hex(16)
        member_confirm = OuranosMailer.membership_confirm(self, token)
        member_confirm.deliver
        MemberConfirm.create({:user => self, :send_date => Time.now, :token => token})
      end
    end
    
    def set_is_expiried
      self.is_expiried = true if self.role && self.role.name == "member" && DateTime.now > self.expiry_date
    end
  
end
