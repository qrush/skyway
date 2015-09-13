module Variant
  extend ActiveSupport::Concern

  included do
    before_action :set_variant
    helper_method :variant, :variant?
  end

  private

  def set_variant
    case request.user_agent
    when /Warren/
      request.variant = :native
    else
      request.variant = :all
    end
  end

  def variant
    request.variant.first.to_s
  end

  def variant?
    variant != "all"
  end
end
