Ouranos::Application.routes.draw do

 resources :widgets, :only => [:show]
  
  mount Refinery::Core::Engine, :at => '/'

end
