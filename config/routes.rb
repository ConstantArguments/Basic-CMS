Rails.application.routes.draw do

  # root_path
  root :to => 'public#index' # So it doesn't go to that default welcome to Rails page anymore. Rails perfers this over 'public/index' for generating URL

  # using permalink here with the symbol in front of it, it's going to be captured and it will be available in my params
  # :as specifies prefix for match route and allows argument to be passed in (see "_navigation.html.erb")
  get 'show/:permalink', :to => 'public#show', :as => 'public_show'

  # for user login, no model or db, so not resourceful just simple
  get 'admin', :to => 'access#menu'
  get 'access/menu'
  get 'access/login'
  post 'access/attempt_login'
  get 'access/logout'


  # resourceful routes
  resources :subjects do # adds seven of basic CRUD pages, but no delete
    member do
      # get request for delete page
      get :delete
    end
  end

  resources :pages do
    member do
      get :delete
    end
  end

  resources :sections do
    member do
      get :delete
    end
  end

  resources :admin_users, :except => [:show] do
    member do
      get :delete
    end
  end

  get 'demo/index' # simple match route which will match demo/hello and send it to the demo controller and the index action
  get 'demo/hello' # simple match route which will match demo/hello and send it to the demo controller and the hello action.
  get 'demo/other_hello'
  get 'demo/google'
  get 'demo/escape_output'

  # default route example if "get" not specified: (may go away in future versions of Rails)
    # get ':controller(/:action(/:id))'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
