class UnauthenticatedController < ActionController::Metal
  include ActionController::UrlFor
  include ActionController::Redirecting
  include Rails.application.routes.url_helpers
  include Rails.application.routes.mounted_helpers

  delegate :flash, :to => :request

  def self.call(env)
    @respond ||= action(:respond)

    @respond.call(env)
  end

  def respond
    flash.alert = I18n.t('Unauthorized user.')

    redirect_to new_sessions_url
  end
end
