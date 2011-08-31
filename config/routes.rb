Ouranos::Application.routes.draw do

  devise_for :users

  scope "(/:locale)" do
    match "/member/be_a_member" => "membership#index", :as => :be_member
    match "/member/confirming" => "membership#show", :as => :member_confirming
    match "/member/conrimed" => "membership#update", :as => :member_confirmed
    match "/subscribes" => "subscribes#index", :as => :subscribes, :via => :get
    match "/subscribes" => "subscribes#create", :as => :subscribes, :via => :post
    match "/subscribes/testlink" => "subscribes#show", :as => :subscribe_testlink
    match "/search" => "search#index", :as => :search
    resources :events
    match "/events/year/:year" => "events#index", :as => :events_year
    resources :comments
    # resources :categories
    match "/posts" => "posts#index", :as => :posts
    match "/post/:permalink" => "posts#show", :as => :post, :requirements => { "permalink" => /[-_a-z0-9]/ }
    match "/posts/print/:id" => "posts#print", :as => :post_print
    match "/posts/pdf/:id" => "posts#to_pdf", :as => :post_to_pdf
    match "/page/:permalink"   => "pages#show", :as => :page, :requirements => { "permalink" => /[-_a-z0-9]/ }
    mount RailsAdmin::Engine => '/iadmin', :as => 'admin'
  end
  
  root :to => 'pages#index'

end
