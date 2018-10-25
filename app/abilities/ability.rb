# frozen_string_literal: true

require 'cancancan'

class Ability
  include CanCan::Ability
  VIEW_PERMISSION = :view
  ADD_PERMISSION = :add
  MODIFY_PERMISSION = :modify
  DELETE_PERMISSION = :delete
  MANAGE_PERMISSION = :manage
  PERMISSIONS = [
    VIEW_PERMISSION,
    ADD_PERMISSION,
    MODIFY_PERMISSION,
    DELETE_PERMISSION,
    MANAGE_PERMISSION
  ].freeze

  def initialize(user)
    PERMISSIONS.each do |permission|
      send("#{permission}_permission", user) if user.permit?(permission)
    end
    merge(ArticleAbility.new(user))
  end

  def view_permission(_)
    can :read, :all
  end

  def add_permission(_)
    can :create, :all
  end

  def modify_permission(_)
    # can :update, :all
  end

  def delete_permission(_)
    # can :destroy, :all
  end

  def manage_permission(_)
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
