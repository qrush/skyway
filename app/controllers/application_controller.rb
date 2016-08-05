class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Admin

  before_action :load_current_fan

  helper_method :signed_in?, :current_fan

  private

  attr_accessor :current_fan

  def load_current_fan
    @current_fan = Fan.find_by_id(session[:fan_id]) || NullFan.new
  end

  def require_current_fan
    head :forbidden unless signed_in?
  end

  def signed_in?
    @current_fan.present?
  end
end
