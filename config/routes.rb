Ouranos::Application.routes.draw do

  scope "(/:locale)" do
    resources :posts
    resources :users
    match '/page/:permalink'   => "pages#show", :as => :page, :requirements => { "permalink" => /[-_a-z0-9]/ }
    mount RorshackAdminUi::Engine => "/iadmin", :as => "iadmin"
  end
  
  mount RorshackAuthentication::Engine => "/iauth", :as => "iauth"

  # the root of the website
  root :to => "pages#index"
end
