# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new

      if user.role == 'user'
        can :manage, :all, user_id: user.id
        can :read, Recipe, public: true
      else
        can :read, Recipe, public: true
      end

  end
end
