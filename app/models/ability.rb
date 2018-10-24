require 'cancancan'

class Ability
  include CanCan::Ability

  def initialize(user)
    user.permissions.map { |permission| send("#{permission}_permission", user) }
  end

  def view_permission(user)
    can :read, :all
  end

  def add_permission(user)
    can :create, :all
  end

  def modify_permission(user)
    can :update, :all
  end

  def delete_permission(user)
    can :destroy, :all
  end

  def manage_permission(user)
    can :manage, :all
  end

  # def admin_abilities(user)
  #   can :manage, :all
  # end

  # def member_abilities(user)
  #   can :read, :all
  #   can :manage, Article, author_id: user.id
  #   can %i[read update], User, id: user.id
  # end

  # def visitor_abilities(user)
  #   can :read, :all
  # end

  def to_list
    rules.map do |rule|
      object = { actions: rule.actions, subject: rule.subjects.map { |s| s.is_a?(Symbol) ? s : s.name } }
      object[:conditions] = rule.conditions unless rule.conditions.blank?
      object[:inverted] = true unless rule.base_behavior
      object
    end
  end
end
