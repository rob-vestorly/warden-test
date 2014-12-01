class User
  include Mongoid::Document

  field :email, :type => String

  has_many :credentials
end
