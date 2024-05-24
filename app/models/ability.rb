# frozen_string_literal: true

# The Ability class defines the user permissions for different actions within the application.
# It uses the CanCanCan gem to manage authorization rules.
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    return unless user

    if user.admin?
      admin_ability(user)
    elsif user.hr?
      hr_ability(user)
    elsif user.user?
      user_ability(user)
    end
  end

  private

  def admin_ability(_user)
    can :manage, :all
    can :index, Api::V1::HomeController
  end

  def hr_ability(user)
    # Define HR abilities here
  end

  def user_ability(user)
    # Define user abilities here
  end
end
