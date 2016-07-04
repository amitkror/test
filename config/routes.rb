NycCollegeLine::Application.routes.draw do

  devise_for :users,
    controllers: {
      confirmations: :confirmations,
      registrations: :registrations,
      passwords: :passwords,
    },
    path_names: {
      password: 'forgot',
      registration: 'register',
      sign_up: 'signup'
    },
    skip: [:sessions]

  match '/ask-an-adviser' => 'guest_questions#redirect'
  match '/global-search' => 'search#global_search' , as: 'global_search'
  get 'feed' => 'blog_posts#feed'

  as :user do
    get 'login' => 'sessions#new', as: :new_user_session
    post 'login' => 'sessions#create', as: :user_session
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
    match 'registrations/success/:step' => 'registrations#success',
      as: :registration_success
  end

  #
  # Public folders
  #
  resources :folders, only: [:index]

  match '/folders/:id/:slug' => 'folders#show', :as => :folder

  namespace 'admissions', as: 'admin' do


    resources :blog_posts do
      get 'confirm_destroy', on: :member
    end
   
    resources :campaign_ppcs  do
      get 'confirm_destroy', on: :member
    end

    resources :tags

    resources :assets, except: [:show,] do
      get 'browse', on: :collection
      get 'confirm_destroy', on: :member
      post 'details', on: :member
      get 'search', on: :collection
    end

    resources :audiences, :events, :faqs, :forums, :glossary_terms,
              :organizations, :phases, :promo_instances, :scholarships,
              :scholarship_submissions,
                :system_avatars, except: [:show,] do
      get 'confirm_destroy', on: :member
    end

    resources :comments, except: [:show, :new, :create,] do
      get 'confirm_destroy', on: :member
    end

    resources :contact_submissions, only: [:index, :show, :destroy]

    resources :contests do
      get 'confirm_destroy', on: :member
    end

    resources :folders, only: [:index, :show, :update]

    resources :folder_recommendations, only: [:index, :show, :destroy], path: 'recommendations'

    resources :galleries, except: [:show,] do
      get 'browse', on: :collection
      get 'confirm_destroy', on: :member
    end

    resources :glossary_imports, only: [:create, :new,]

    resources :pages, except: [:show,] do
      get 'confirm_destroy', on: :member
      post 'update_order', on: :collection
    end

    resources :questions, except: [:show, :new, :create] do
      get 'confirm_destroy', on: :member
    end

    resources :guest_questions, except: [:show, :new, :create] do
      get 'confirm_destroy', on: :member
    end

    resources :referral_codes, only: [:create]

    resources :resource_imports, only: [:create, :new,]

    resources :resources, except: [:show,] do
      get 'confirm_destroy', on: :member
      get 'search', on: :collection
    end

    resources :resource_suggestions, except: [:show, :new, :create,] do
      get 'confirm_destroy', on: :member
    end

    resources :site_settings, only: [:edit, :update,]

    resources :users, except: [:show,] do
      get 'confirm_destroy', on: :member
      get 'search', on: :collection
    end

    root to: 'admissions#index'
  end

  namespace 'guest-profile', as: :guest_profile do
    resources :guest_questions, path: 'guest-ask-an-adviser', only: [:new, :create, :show] do
      match 'build', on: :collection
      get 'success', on: :collection
    end
    root to: 'guest_questions#index'
  end

  namespace 'profile', as: :profile do

    resources :advisers, only: [:index, :show]

    resources :contests, only: [:index] do
      resources :referral_emails, only: [:new, :create]
    end

    resources :folder_recommendations, only: [:new, :create]

    resources :folders, except: [:new] do
      resources :folder_emails, only: [:new, :create]

      member do
        get 'clone'
      end

    end

    resources :forum_threads, path: 'forums', only: [:index]

    resources :questions, path: 'ask-an-adviser', only: [:new, :create, :show] do
      get 'success', on: :collection
    end

    resources :resource_suggestions, path: 'suggest-resource',
      only: [:new, :create]

    resources :resources, only: [:index, :new, :create, :edit, :update]

    resources :settings, only: [:index] do
      put :update_avatar, on: :collection
      put :update, on: :collection
      get :confirm_destroy, on: :collection
      delete :destroy, on: :collection
    end
    match 'settings/audience' => 'settings#audience'
    match 'settings/newsletter' => 'settings#newsletter'
    root to: 'folders#index'
  end

  resources :avatars, only: [:create, :destroy]
  resources :comments, only: [:destroy]
  resources :conditions_of_use, path: 'conditions-of-use', only: [:index]

  resources :contact_submissions, path: 'contact-us',
    only: [:index, :new, :create]

  resources :events, only: [:index, :show] do
    resources :comments, only: [:create]
  end
  match 'events/:year/:month/:day' => 'events#date'
  match 'events/:year/:month' => 'events#monthdate'

  resources :faqs, path: 'faq', only: [:index]

  resources :forums, only: [:index, :show] do
    match 'search', on: :collection
    resources :forum_threads, path: 'threads', only: [:index, :show]
  end

  resources :forum_threads, path: 'threads', only: [:new, :create, :destroy] do
    resources :comments, only: [:create]
  end

  resources :glossary, only: [:index]

  match 'newsletter-hooks' => 'newsletter_hooks#index'

  resources :organizations, only: [:show]

  resources :questions, only: [:index] do
    resources :comments, only: [:create]
  end

  resources :guest_questions, only: [:index] do
    resources :comments, only: [:create]
    resources :guest_comments, only: [:create]
  end

  resources :resources, only: [:show] do
    post 'helpful', on: :member
    resources :bookmarks, only: [:create, :update] do
      match 'move', on: :collection
      match 'toggle', on: :collection
      match 'sort', on: :collection
    end
    resources :comments, only: [:create]
  end

  match 'blog/date/:date' => 'blog_posts#by_date', as: :blog_date
  match 'blog/category/:category' => 'blog_posts#by_category', as: :blog_category
  resources :blog_posts, only: [:index, :show], path: 'blog' do
    resources :comments, only: [:create]
  end

  resources :scholarships, only: [:index, :show] do
    resources :scholarship_submissions, only: [:create, :show] do
      resources :user_submission_votes, only: [:create, :destroy]
    end
  end

  resources :campaign_ppcs, only: [:show], path: 'campaign-ppc'
  
  resources :contacts, only: [:new, :create]

  match 'search' => 'search#index', as: :search

  get '*id' => 'application#show', as: :page

  root to: 'home#index'

 end
