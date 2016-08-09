Inz::Application.routes.draw do
  #DEFAULT
  resources :blog_categories, :only => [:show]
  get 'search_car', :to => 'welcome#search_car', :as=>:search_car
  get 'blogposts/:id', :to => 'blog_categories#blogpostshow', :as=>:blogpost
  get 'static/:page', :to => 'blogposts#static', :as=>:static
  post 'InsCarQuo/PingAn/:task', :to=> 'pingan#sink', :defaults => { :format => 'json' }
  #post 'InsCarQuo/PingAn/sendHighestBiddingInfo', :to=> 'pingan#funk', :defaults => { :format => 'json' }
  #post 'InsCarQuo/PingAn/receiveAuction', :to=> 'pingan#funk', :defaults => { :format => 'json' }
  get  'InsCarQuo/PingAn/:task', :to=> 'pingan#test', :defaults => { :format => 'json' }

  resources :cars, :only => [:index, :show] do
    get :get_models, :on => :collection
    get :get_model, :on => :member
  end

  resources :auctions, :only => [:index, :show] do
    resources :offers, :only => [:new, :create] do
      #get :to_reject, :on => :member
    end
    resources :ratings, :only => [:index, :create]
    get :result, :on => :collection
    get :search, :on => :collection
    get :apply, :on => :member
    post :apply, :on => :member
    get :applied, :on => :member
    post :bid, :on => :member
    get :start, :on => :member
    get :close, :on => :member
  end

  #Users and sessions
  resources :users do
  	member do
  		get :watching, :watchers, :edit_company, :show_company, :edit_password
  		patch :update_company, :update_password
  	end
  	resources :userprojects, :only => [:index]
  	resources :blogposts do
  		member do
  			get :admin
  		end
  	end
  	resources :portfolios
  	resources :bonuspoints, :only => [:index] do
  		member do
  			get :addfromblog
  		end
  	end
  end
  resources :sessions, :only => [:new, :create, :destroy] do
    get :backend_new, :on => :collection
    post :backend_create, :on => :collection
    post :get_vercode, :on => :collection
    put :get_vercode, :on => :collection
  end

  resources :relationships, :only => [:create, :destroy]
  #resources :blogposts
  resources :blogcomments do
  	member do
  		get :admin
  	end
  end
  resources :bonuspoints
  get '/signup',  :to => 'users#new'
  get '/signin',  :to => 'sessions#new'
  match '/signout',  :to => 'sessions#destroy', via: [:get, :delete]
  get '/ver', :to => 'users#mail_ver'
  #get '/find', :to => 'users#find'
  #get '/delete', :to => 'users#delete'

  # PANEL
  namespace :panel do

    resources :auctions, :except => [:show] do
      resources :communications, :only => [:new, :create]
      get :offers, :on => :member # offers#index dla wlasnych ofert zarezerwowane
      get :user_form, :on => :collection
      resources :offers, :only => [:destroy, :new, :create] do
        #get :to_reject, :on => :member
      end
      #resources :alerts, :only => [:index, :show] do
      #  member do
      #    get :reject_offer
      #  end
      #end
    end

    resources :offers, :only => [:index] do
      post :to_reject, :on => :member
    end
    resources :comments do
      get :queue, :on => :collection
    end
    resources :messages, :except => [:edit, :update] do
      get :reply, :on => :member
      get :sent, :on => :collection
    end

    resources :projects, :only => :index
  end

  #ADMIN
  namespace :admin do
    resources :alerts, :only => [:index, :show, :destroy]
    resources :auctions, :except => [:show] do
      resources :offers, :only => [:destroy] do
        get :recovery, :on => :member
      end
    end
    resources :messages, :except => [:edit, :update] do
      get :reply, :on => :member
      get :sent, :on => :collection
    end
    resources :cars do
      get :accident, :on => :collection
      get :used, :on => :collection
      get :accessory, :on => :collection
      post :create_used, :on => :collection
      post :create_accessory, :on => :collection
      get :show_used, :on => :member
      get :show_accessory, :on => :member
      get :edit_used, :on => :member
      get :edit_accessory, :on => :member
      patch :update_used, :on => :member
      patch :update_accessory, :on => :member
      get :new_used, :on => :collection
      get :new_accessory, :on => :collection

    end
    resources :groups, :except => [:show]
    resources :tags, :except => [:show]
    resources :communications, :only => [:destroy]
    resources :users do
    	get :blogposts, :on => :member
      resources :comments, :only => [:index, :edit, :update]
    end
  end
  get 'admin/cars/search', :to => 'admin/cars#search'
  get 'admin/users/:id/points', :to => 'admin/users#points'
  get 'admin/users/:id/editpoints', :to => 'admin/users#editpoints'
  get 'admin/users/:id/status/:status/delete', :to => 'admin/users#delete'
  get 'admin/blogposts', :to => 'admin/users#blogposts', :via => :get
  get 'admin/blogposts/new', :to => 'admin/users#blogpostnew'
  post 'admin/blogposts', :to => 'admin/users#blogpostnew2', :via => :post
  get 'admin/blogposts/:id', :to => 'admin/users#blogpostok'
  get 'admin/blogpost/:id', :to => 'admin/users#blogpostedit'
  get 'admin/blogpost/:id/edit', :to => 'admin/users#blogpostedit2'
  get 'admin/blogposts/delete/:blogpost', :to => 'admin/users#deleteblogpost'
  get 'admin/blogcomments', :to => 'admin/users#blogcomments'
  get 'admin/blogcomments/:id', :to => 'admin/users#blogcommentok'
  get 'admin/blogcomments/delete/:blogcomment', :to => 'admin/users#deleteblogcomment'

  #PROJECT
  #scope :module => "project" do
  #  resources :projects do
  #    resource :info, :only => [:show, :update], :controller => "info"
  #    resources :members, :only => [:index, :update, :destroy]
  #    resources :files, :except => [:edit]
  #    resources :invitations, :except => [:show, :update] do
  #      get :accept, :on => :member
  #      get :reject, :on => :member
  #      get :cancel, :on => :member
  #    end
  #    resources :topics do
  #    	resources :posts, :except => [:index, :show]
  #    end
  #    resources :tickets do
  #      get :take, :on => :member
  #      get :give, :on => :member
  #      get :end, :on => :member
  #    end
  #  end
  #end

  get 'case/cars/list/:status', :to => 'case/cars#list', :as=>:list_case_cars_by_status
  get 'case/cars/search', :to => 'case/cars#search'
  get 'case/cars/show_pickup_car', :to => 'case/cars#show_pickup_car'
  get 'case', :to => 'case/cars#welcome'
  get 'case/companies/list', :to => 'case/companies#list', :as=>:case_company_list
  get 'case/users/list', :to => 'case/users#list', :as=>:case_user_list

  namespace :case do
    resources :cars do
      post :upload_file, :on => :collection #new car
      put :upload_file, :on => :collection  #edit car
      delete :delete_file, :on => :collection #delete file have not assigned to car
      get :new_car_accident, :on => :collection
      get :welcome, :on => :collection
      get :raise_error, :on => :collection
      member do
        patch :evaluate
        patch :abandon
        match :sendback, via: [:put, :patch]
        patch :pickup
        patch :abandon2
        patch :abandon3
        patch :confirm_transfer
        patch :new_auction
        patch :feedback_auction
        patch :confirm_auction
        patch :quoted_price
        post :upload_doc
      end
    end
    resources :companies, :users
  end

  resources :alerts, :only => [:create]



  root :to =>  "welcome#index"

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
