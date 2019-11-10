class AdminsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: Skyway.admin_password

  def show
    admin!
    redirect_to setlists_path
  end
end
