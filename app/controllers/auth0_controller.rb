class Auth0Controller < ApplicationController
  skip_before_action :load_current_fan

  def callback
    auth = request.env['omniauth.auth']

    if identity = Identity.find_by_user_id(auth.uid)
      session[:fan_id] = identity.fan_id
    else
      fan = Fan.new(handle: auth.extra.raw_info.screen_name || auth.info.nickname, picture: auth.info.image)
      fan.identities.build(user_id: auth.uid)
      fan.save!
      session[:fan_id] = fan.id
    end

    redirect_back
  end

  def failure
    @error_msg = request.params['message']
    render text: @error_msg
  end

  def logout
    reset_session
    self.current_fan = NullFan.new
    redirect_back
  end

  private

  def redirect_back
    if params[:back_to] =~ %r{\A/}
      redirect_to params[:back_to]
    else
      redirect_to root_path
    end
  end
end
