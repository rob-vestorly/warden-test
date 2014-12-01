class PasswordStrategy < ::Warden::Strategies::Base
  class AuthenticationError < StandardError; end

  def valid?
    return false if request.get?

    user_data = params.fetch("user", {})

    !(user_data["email"].blank? || user_data["password"].blank?)
  end

  def authenticate!
    user = User.where(:email => params["user"].fetch("email")).first
    raise AuthenticationError if user.blank?

    credentials = user.credentials.where(:credential_type => 'password')
    raise AuthenticationError if credentials.blank?

    credential = credentials.to_a.find { |credential| credential.password == params["user"].fetch("password") }
    raise AuthenticationError if credential.blank?

    success! user
  rescue AuthenticationError
    fail! :message => "strategies.password.failed"
  end
end

Warden::Strategies.add(:password, PasswordStrategy)
