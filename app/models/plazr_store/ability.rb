module PlazrStore
  class Ability
    include CanCan::Ability

    def initialize(user, namespace)
      case namespace
        when 'Admin'
          can :admin, :all if user.is_admin?
        else
          can :read, Product
      end
    end
  end
end
