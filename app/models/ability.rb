class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # in case of guest
    
    if !user.role
      cannot :access, :all
    else
      can :access, :rails_admin
    
      cannot :manage, Role
      cannot :manage, User
      
      case user.role.name.to_sym
      when :admin
        as_admin user
      when :member
        as_member user
      end
    end

  end
  
  private
  #
  # what admin can do
  #
  def as_admin user
    can :manage, :all
    cannot :new, Comment
  end
  
  #
  # what member can do
  #
  def as_member user
    can :read, User, :id => user.id
    can :update, User, :id => user.id
    can :read, Comment, :user_id => user.id
  end
  
end
