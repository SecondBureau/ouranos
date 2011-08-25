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
      when :officer
        as_officer user
      when :member
        as_member user
      when :user
        as_user user
      when :guest
        as_guest user
      end
    end

  end
  
  private
  #
  # what admin can do
  #
  def as_admin user
    can :manage, :all
  end
  
  #
  # what officer can do
  #
  def as_officer user
    can :manage, Post
    can :manage, Comment
    can :manage, User
    
    admin_id = Role.where('name = ?', 'admin').first.id;
    officer_id = Role.where('name = ?', 'officer').first.id;
    
    cannot :manage, User, :role_id => [admin_id, officer_id]
    can :update, User, :id => user.id
    can :read, User, :role_id => officer_id
    can :read, Role
    cannot :read, Role, :id => [admin_id, officer_id]
  end
  
  #
  # what member can do
  #
  def as_member user
    can :read, User, :id => user.id
    can :update, User, :id => user.id
    can :read, Comment, :user_id => user.id
  end
  
  #
  # what user can do
  #
  def as_user user
    can :update, User, :id => user.id
    can :read, Comment, :user_id => user.id
  end
  
  #
  # what guest can do
  #
  def as_guest user
    cannot :access, :rails_admin
  end
  
end
