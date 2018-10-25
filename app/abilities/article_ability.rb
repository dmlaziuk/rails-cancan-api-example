class ArticleAbility
  include CanCan::Ability
  def initialize(user)
    can :read, Article
    can :create, Article if user.permit?(Ability::ADD_PERMISSION)
    can :update, Article, user_id: user.id if user.permit?(Ability::MODIFY_PERMISSION)
    can :destroy, Article, user_id: user.id if user.permit?(Ability::DELETE_PERMISSION)
  end
end
