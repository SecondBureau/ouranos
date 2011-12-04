Ouranos::Application.routes.draw do


  devise_for :users

  scope "(/:locale)" do
    match "/member/be_a_member" => "membership#index", :as => :be_member
    match "/member/confirming" => "membership#show", :as => :member_confirming
    match "/member/confirmed" => "membership#update", :as => :member_confirmed
    match "/subscribes" => "subscribes#index", :as => :subscribes, :via => :get
    match "/subscribes" => "subscribes#create", :as => :subscribes, :via => :post
    match "/subscribes/testlink" => "subscribes#show", :as => :subscribe_testlink
    match "/search" => "search#index", :as => :search
    match "/search/more/:model" => "search#show", :as => :search_more
    resources :events
    match "/events/year/:events_year" => "events#index", :as => :events_year
    resources :comments
		match "/posts" => "posts#index", :as => :posts
    match "/posts/category/:category_id" => "posts#index", :as => :posts_with_category
    match "/post/:permalink" => "posts#show", :as => :post, :requirements => { "permalink" => /[-_a-z0-9]/ }
    match "/posts/print/:id" => "posts#print", :as => :post_print
    match "/posts/pdf/:id" => "posts#to_pdf", :as => :post_to_pdf
    match "/page/:calendar_option/:year/:month" => "pages#index", :as => :page_calendar
    match "/page/:permalink"   => "pages#show", :as => :page, :requirements => { "permalink" => /[-_a-z0-9]/ }
    match "/event/:daystring" => "events#of_day", :as => :events_of_day
    mount RailsAdmin::Engine => '/admin', :as => 'admin'
    
   
    
  end
  
  match '/assets/powered-by-secondbureau' => 'recipients#opening_track'
   match '/assets/powered-by-secondbureau.png' => 'recipients#opening_track'

  root :to => 'pages#index'
  
  match '*path' => 'pages#index'

end

