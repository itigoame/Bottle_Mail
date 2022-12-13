Rails.application.routes.draw do

  get 'notifications/index'
  devise_for :members, skip: [:passwords] , controllers: {
  registrations: "member/registrations",
  sessions: 'member/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :members,       only: [:show, :edit, :index, :update] do
      resources :rooms,       only: [:show, :index] do
      end
    end
    resources :chats,         only:  :destroy
    resources :categories,    only: [:create, :index, :edit, :update, :destroy, :show] do
      resources :genres,      only: [:create, :edit, :update, :destroy]
      resources :posts,       only:  :index
    end
    resources :posts,         only: [:show, :destroy] do
    resources :relationships, only:  :index
    resources :comments,      only:  :destroy
    end
    resources :reports,       only: [:index, :show, :update]

  end

  devise_scope :member do
    # ユーザー登録失敗時のリダイレクトのエラー防止
    get '/members', to: 'member/registrations#new'
  end

  scope module: :member do
    resources :members,       only:   [:show, :edit, :update] do
      resources :empathies,   only:    :index
      resources :reports,     only:   [:new, :create]
      get       :followers, :followings
    end
    resource  :relationships, only:   [:create, :destroy]
    resources :rooms,         only:   [:create, :show, :index] do
    resources :chats,         only:   [:create, :destroy]
    end
    resources   :posts,       except: [:edit, :index] do
      resource  :empathies,   only:   [:create, :destroy]
      resources :comments,    only:   [:create, :destroy]
    end
    resources   :categories,  only:   :index do
      resources :genres,      only:   :index
      resources :posts,       only:   :index
    end
    resources :notifications, only:   :index

    # delete  ':notifications' => "notifications#destroy_all"

    root to: 'homes#top'
    get      ':id/unsubscribe' => 'members#unsubscribe', as: 'unsubscribe'
    patch    ':id/withdrawal'  => 'members#withdrawal',  as: 'withdrawal'
    get '/get_genres'          => 'categories#get_genres'

  end

  get "search"       => "searches#search"
  get "admin_search" => "searches#admin_search"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end