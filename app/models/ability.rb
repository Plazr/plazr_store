class Ability
  include CanCan::Ability
  def initialize(user, namespace = nil)
    @user = user || PlazrAuth::User.new

    @user.roles.each { |role| send role.name.downcase }
    #case namespace
    #  when 'Admin'
    #    can :admin, :all if user.is_admin?
    #  else
    #    can :read, PZS::Product
    #end
  end

  # unregistered users
  # (all users have these permissions)
  def unregistered
    can :read, PZS::Product
    can :read, PZS::Page
  end


  def user
    unregistered
    # can manage his own wishlist
    can :access, :wishlist_actions
    # can :manage, PZS::Wishlist, user_id: @user.id

    # can manage his own cart
    can :access, :cart_actions
    # can :manage, PZS::Cart, user_id: @user.id

    # can access and create his own orders
    can :access, :orders_actions
    can :create, PZS::Order, user_id: @user.id
    can :read, PZS::Order, user_id: @user.id
  end


  def staff
    user
    can :manage, :store
  end


  def admin
    staff
    can :admin,  :store
  end

  # in plazr_store, a root can do the same as an admin
  def root
    admin
  end

end
