Ouranos::Application.routes.draw do

  scope "(/:locale)" do
    resources :managements
    resources :posts
    resources :users
    resources :comments
    resources :categories
    match "/post/print/:id" => "posts#print", :as => :post_print
    match "/page/:permalink"   => "pages#show", :as => :page, :requirements => { "permalink" => /[-_a-z0-9]/ }
    match "/users/:id/opers/:oper" => "users#show", :as => :user_oper
    match "/managements/opers/:oper" => "managements#show", :as => :management_oper
    match "/managements/opers/:oper/:id" => "managements#detail", :as => :management_oper_detail
    mount RorshackAdminUi::Engine => "/iadmin", :as => "iadmin"
  end
  
  mount RorshackAuthentication::Engine => "/iauth", :as => "iauth"

  # the root of the website
  root :to => "pages#index"
end
