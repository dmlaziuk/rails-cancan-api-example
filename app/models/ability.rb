require 'cancancan'

class Ability
  include CanCan::Ability

  PERMISSIONS = %w[view add modify delete].freeze

  def initialize(user)
    PERMISSIONS.each do |permission|
      send("#{permission}_permission", user) if user.permit?(permission)
    end
  end

  def view_permission(user)
    can :read, :all
  end

  def add_permission(user)
    can :create, :all
  end

  def modify_permission(user)
    can :update, Article, author_id: user.id
  end

  def delete_permission(user)
    can :destroy, Article, author_id: user.id
  end

  def manage_permission(user)
    can :manage, :all
  end

  def to_list
    rules.map do |rule|
      object = { actions: rule.actions, subject: rule.subjects.map { |s| s.is_a?(Symbol) ? s : s.name } }
      object[:conditions] = rule.conditions unless rule.conditions.blank?
      object[:inverted] = true unless rule.base_behavior
      object
    end
  end
end
