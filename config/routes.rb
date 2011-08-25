Ouranos::Application.routes.draw do

  devise_for :users

  resources :events
  resources :posts
  resources :comments
  # resources :categories
  match "/posts/print/:id" => "posts#print", :as => :post_print
  match "/posts/pdf/:id" => "posts#to_pdf", :as => :post_to_pdf
  match "/page/:permalink"   => "pages#show", :as => :page, :requirements => { "permalink" => /[-_a-z0-9]/ }

  mount RailsAdmin::Engine => '/iadmin', :as => 'rails_admin'

  root :to => 'pages#index'

end
