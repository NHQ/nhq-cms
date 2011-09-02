Clown::Application.routes.draw do  

  resources :venues

  devise_for :users do
    get "login", to: "devise/sessions#new"
  end

  # devise_for :users

  resources :users, :only => :show

  resources :flickrs do
    get 'refetch', :on => :collection
  end

  resources :workshops do
    resources :reviews
    resources :flickrs
    resources :videos
  end

  resources :shows do
    resources :reviews
    resources :credits
    resources :flickrs
    resources :videos
  end
  
  resources :reviews
  resources :credits
  resources :videos

  resources :promotions do
    resources :videos
  end

  match '/events/feed', :as => "feed", :to => "events#feed"

  resources :events do
    resources :venues
    resources :showdates
    resources :flickrs
    resources :videos
  end

  resources :showdates

  resources :pages do
    resources :flickrs
    resources :videos
  end
  
  match '/shows/:show_id/add_review', :as => "add_review", :to => "shows#add_review"
  match '/shows/:show_id/reviews/:review_id/remove', :as => "remove_review", :to => "shows#remove_review"

  match '/workshops/:workshop_id/add_review', :as => "add_review", :to => "workshops#add_review"
  match '/workshops/:workshop_id/reviews/:review_id/remove', :as => "remove_review", :to => "workshops#remove_review"

  match '/events/:event_id/add_venue', :as => "add_venue", :to => "events#add_venue"
  match '/events/:event_id/venues/:venue_id/remove', :as => "remove_venue", :to => "events#remove_venue"
  
  # match '/:slug' => 'pages#show'
  
  root :to => "pages#home"
  
#  match ':controller/:action/:id/:review_id'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

end
