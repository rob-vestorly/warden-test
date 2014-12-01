Dir[Rails.root.join *%w(lib strategies ** *.rb)].each { |file| require file }

Warden::Manager.serialize_into_session do |user|
  user.id
end

Warden::Manager.serialize_from_session do |id|
  User.find(id)
end
