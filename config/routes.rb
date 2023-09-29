Rails.application.routes.draw do
  namespace :public do
    get 'group_users/create'
    get 'group_users/destroy'
  end
  namespace :public do
    get 'groups/index'
    get 'groups/new'
    get 'groups/show'
    get 'groups/edit'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :customer do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  namespace :admin do
    resources :customers, only: [ :index, :create, :show, :edit, :update ] do
      resource :relationships, only: [:create, :destroy]
      	get "followings" => "relationships#followings", as: "followings"
      	get "followers" => "relationships#followers", as: "followers"
    end
    resources :posts, only: [ :index, :show, :edit, :update ] do
      resources :post_comments, only: [ :create, :destroy ]
      resource :favorites, only: [ :create, :destroy ]
    end
    get "search" => "searches#search"
  end


  scope module: :public do
    root to: "homes#top"

    get "/about" => "homes#about"
    get "customer/mypage" => "customers#mypage", as: "mypage"
    get "customer/information" => "customers#edit", as: "information"
    patch "customer/information/update" => "customers#update", as: "information_update"
    get "customer/confirm_withdraw" => "customers#confirm_withdraw", as: "confirm_withdraw"
    get "customers/withdraw" => "customers#withdraw", as: "withdraw"
    patch "/customers/withdraw" => "customers#withdraw"
    get "customer/timeline" => "customers#timeline", as: "timeline"
    get "search_tag" => "posts#search_tag"
    get "search" => "searches#search"

    resources :customers, only: [ :show, :edit] do
      member do
        get :favorites
        get :user_groups
      end
      resource :relationships, only: [:create, :destroy]
      	get "followings" => "relationships#followings", as: "followings"
      	get "followers" => "relationships#followers", as: "followers"
    end

    resources :posts do
      resources :post_comments, only: [ :create, :destroy ]

      resource :favorites, only: [ :create, :destroy ]
    end

    resources :notifications, only: [:index, :destroy]

    resources :groups do
      resource :group_users, only: [:create, :destroy]
    end

  end


end
