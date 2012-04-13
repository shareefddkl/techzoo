Project::Application.routes.draw do
  match '/forgot_password', :controller => "users", :action => "forgot_password"
  match '/admino', :controller => "admino", :action => "index"
  resources :chat do
    collection do
      post :send_data
     
    end
  end
  resources :ads
  resources :suggestions
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end
  resources :blogs do
    collection do
      get :search
    end
  end
  resources :defaults do
    collection do
      get :terms
      get :faq
      get :career
      get :demo
      get :news_events
      get :about
    end
  end

  resources :users do
    collection do
      post :send_reset_password_instructions
      get :photo
      post :update_photo
      get :setting
      put :update_email
      get :photo
      post :update_photo
      get :newpost
      post :blogview
      get :email_setting
      put :update_email_setting
      post :import
      get :notification
      put :update_notification
    end
    member do
      get :activate
      get :reset_password
      put :update_password
    end
  end
  
  resources :sessions
  root :to => 'home#index'
  resources :searches do
    collection do
      get :accountid_search
      get :name_search
      get :course_search
      get :advance_search
    end
  end

  resources :feedbacks
  resources :students do
    member do
      get :other_message
      post :student_message
      get :education
      put :update_education
      get :others
      put :update_others
      get :get_education_form
      get :get_education_profile_form
      put :update_education_profile
      get :education_profile
      put :update_work
      get :student_view
    end
    collection do
      put :update_basic_info
      get :basic_info
      get :picture
      get :work
      get :interest
      put :update_interest
      post :invite
      get :invite_friends
    end
  end

  resources :mentors do
    member do
      get :other_message
      post :mentor_message
      get :education
      put :update_education
      get :others
      put :update_others
      get :get_education_form
      put :update_work
      get :feedback
      get :mentor_current_course
      get :get_education_profile_form
      put :update_education_profile
      get :education_profile
      get :mentor_view
    end
    collection do
      put :update_basic_info
      get :basic_info
      get :picture
      get :work
      get :interest
      put :update_interest
      post :invite
      get :invite_friends
      get :mentor_delete
    end
  end
  resources :statuses do
    member do
      
    end
    collection do
      get :mentor_info
      get :student_info
      get :get_mentor
    end
  end
  resources :reports do
    collection do
      get :overview
      get :traffic_source
      get :member_search
      get :member_report
    end

  end

  resources :home

  resources :courses do
    resources  :documents do
      resources :discussions
    end
    resources :videos do
      resources :comments_videos
    end
    member do
      put :update_course_control
      put :update_course_design
      post :apply
      get :topic
      get :student_list
      get :accept
      get :reject
      post :accept_message
      post :reject_message
      get :student_course_display
      get :get_course_form
      get :mentor_course
    end
    collection do
      get :student_current_course
      get :student_status
      get :course
      get :learner
      get :current
      get :student_course
      get :status
      get :course_control
      get :course_design
      get :course_view
      get :course_apply
      get :feedback
      get :search
      get :search_result
    end
  end

  resources :messages do
    member do
      get :conversation
      post :reply
    end
  end

  resources :others do
    collection do
      get :user_info
      get :feedback
      get :current_course
      get :blog
    end
  end
  resources :sessions
  resources :rooms

  match '/party/:id', :to => "rooms#party", :as => :party, :via => :get
  match '/link/:id', :to => "students#link", :as => :link, :via => :get

  resources :others do
    collection do
      get :user_info
      get :feedback
      get :current_course
      get :blog
    end
  end

  
 

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