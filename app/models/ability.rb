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

      case user.role.name
      when Role::ADMIN
        as_admin user
      when Role::MEMBER
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
    cannot :new, Role
    cannot :new, Setting
    cannot :show, Post
    cannot :show, Category
    cannot :update, Role
    cannot :destroy, Role
    cannot :show, Role
    cannot :show, Comment
    cannot :show, Event
    cannot :show, Page
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

