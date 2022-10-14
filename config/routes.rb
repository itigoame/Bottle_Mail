Rails.application.routes.draw do

  devise_for :members, skip: [:passwords] , controllers: {
  registrations: "member/registrations",
  sessions: 'member/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :members,       only: [:show,   :edit, :index, :update]
    resources :rooms,         only: [:show,   :index]
    resources :categories,    only: [:create, :index, :edit, :update, :destroy, :show] do
      resources :genres,      only: [:create, :index, :edit, :update, :destroy]
      resources :posts,       only:  :index
    end
    resources :posts,         only: [:show, :destroy]
    resources :relationships, only:  :index

  end

  scope module: :member do
    resources :members,       only: [:show,   :edit, :update] do
      get     :followers, :followings
    end
    resource  :relationships, only: [:create, :destroy]
    resources :rooms,         only: [:create, :show, :index] do
    resources :chats,         only: [:create, :destroy]
    end
    resources   :posts,       except: [:edit, :index] do
      resource  :empathies,   only:   [:create, :destroy]
      resources :comments,    only:   [:create, :destroy]
    end
    resources   :categories,  only: :index do
      resources :genres,      only: :index
      resources :posts,    only:  :index
    end
    root to: 'homes#top'
    get      'home/about'      => 'homes#about'
    get      ':id/unsubscribe' => 'members#unsubscribe', as: 'unsubscribe'
    patch    ':id/withdrawal'  => 'members#withdrawal',  as: 'withdrawal'
    get '/get_genres' => 'categories#get_genres'
  end

  get "search" => "searches#search"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end