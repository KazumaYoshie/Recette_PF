Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get "homes/about" => "homes#about"
  devise_for :users
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  put "/users/:id/hide" => "users#hide", as: "users_hide"
end
