class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :admin?

  def admin?
    session[:admin]
  end

  def admin!
    session[:admin] = true
  end

  def require_admin
    redirect_to root_path unless admin?
  end
end
