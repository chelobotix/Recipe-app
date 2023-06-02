class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, :all, user_id: user.id if user.role == 'user'
    can :read, Recipe, public: true
  end
end
