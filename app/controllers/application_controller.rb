class ApplicationController < ActionController::Base
  protect_from_forgery
  prepend_before_filter :authenticate!

  helper_method :warden, :signed_in?, :current_user

  def authenticate!
    warden.authenticate!
  end

  def current_user
    warden.user
  end

  def signed_in?
    !current_user.nil?
  end

  def warden
    request.env['warden']
  end
end
