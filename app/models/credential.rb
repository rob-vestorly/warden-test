require 'bcrypt'

class Credential
  include Mongoid::Document

  CREDENTIAL_TYPES = %w(password).map(&:freeze).freeze

  field :credential_type,  :type => String
  field :credential_value, :type => String

  belongs_to :user

  validates :credential_type,  :presence => true, :inclusion => { :in => CREDENTIAL_TYPES }
  validates :credential_value, :presence => true
  validates :user,             :presence => true

  def password
    password? ? @password || BCrypt::Password.new(self.credential_value) : nil
  end

  def password?
    credential_type == 'password'
  end

  def password=(value)
    @password             = BCrypt::Password.create(value)
    self.credential_type  = 'password'
    self.credential_value = @password
  end
end
