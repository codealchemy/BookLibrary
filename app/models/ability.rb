class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      can :access, :rails_admin
      can :dashboard
      can :read, :all
      can :edit, user
      can :checkout, Book
    end
  end
end
