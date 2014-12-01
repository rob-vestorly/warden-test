WardenTest::Application.routes.draw do
  resource :sessions, :only => %i(new create destroy)

  root :to => 'scaffold#index'
end
