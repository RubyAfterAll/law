# frozen_string_literal: true

# To make something permissible by the enforcement of **Laws**.
module Law
  module Legalize
    extend ActiveSupport::Concern

    included do
      attr_reader :judgement
      helper_method :law if respond_to?(:helper_method)
    end

    def authorized?
      judgement.try(:authorized?) || false
    end

    def adjudicated?
      judgement.try(:adjudicated?) || false
    end

    def violations
      judgement.try(:violations) || []
    end

    def law(target = nil, petitioner = nil, permissions: nil, parameters: nil, law_class: nil)
      target ||= law_default_target
      petitioner ||= law_default_petitioner
      permissions ||= law_permissions_for(petitioner)
      law_class ||= law_class_for(target)

      raise ArgumentError, "a Law is required" unless law_class.is_a?(Class)

      law_class.new(permissions: permissions, source: petitioner, target: target, params: parameters)
    end

    def authorize!(action = nil, **options)
      authorize(action, **options) or raise Law::NotAuthorizedError
    end

    def authorize(action = nil, object: nil, petitioner: nil, permissions: nil, parameters: nil, law_class: nil)
      action ||= law_default_action
      parameters ||= law_default_params

      raise ArgumentError, "an action is required" if action.nil?

      options = { permissions: permissions, parameters: parameters, law_class: law_class }
      @judgement = law(object, petitioner, **options).authorize(action)
      authorized?
    end

    private

    def law_default_target
      @record || try(:controller_name)&.singularize&.camelize&.safe_constantize
    end

    def law_default_petitioner
      try(:current_user)
    end

    def law_permissions_for(petitioner)
      petitioner.try(:permissions)
    end

    def law_class_for(target)
      target.try(:conjugate, Law::LawBase)
    end

    def law_default_action
      try(:action_name)
    end

    def law_default_params
      try(:params)
    end
  end
end
