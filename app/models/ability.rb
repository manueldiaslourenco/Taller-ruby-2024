# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    user ||= User.new(role: nil)


    if user.admin?
      can :manage, :all
    elsif user.manager?
      can :manage, Product
      can :manage, User, role: [0, 1]
      can :read, User, role: 2
      cannot :create, User, role: 2
      cannot :destroy, User, role: 2
      can :manage, Sale
    elsif user.employee?
      # Usamos un bloque para comprobar si el usuario puede leer su propio perfil
      can :read, User do |u|
        u.id == user.id
      end
      can :manage, Product
      can :update_stock, Product
      can :manage, Sale
    else
      can :read, Product
      cannot :update_stock, Product
    end
  end
end
