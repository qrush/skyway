module Admin
  extend ActiveSupport::Concern

  included do
    helper_method :admin?
  end

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
