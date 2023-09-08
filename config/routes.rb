Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do

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

    resources :posts
  end


end
