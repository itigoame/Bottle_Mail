Rails.application.routes.draw do

  namespace :admin do
    resources :members,       only:   [:show, :edit,   :update]
    resources :rooms,         only:   [:show, :index]
    resources :categories,    except: [:new,  :show]
    resources :genres,        except: [:new,  :create, :show]
    resources :posts,         only:   [:show, :index,  :destroy]
    resources :relationships, only:   [:index]

  end

  scope module: :member do
    resources :members,        only:  [:show,   :edit, :update]
    get 'members/unsubscribe'
    get 'members/withdrawal'
    resources :relationships, only:   [:create, :index, :destroy]
    resources :rooms,         only:   [:create, :show,  :index] do
    resources :chats,         only:   [:create, :destroy]
    resources :entries,        only:  [:create]
    end
    resources :posts,         except: [:edit,   :update] do
      resource :enpathy,      only:  [:create, :destroy]
      resources :comments,     only:  [:create, :destroy]
    end
    resources :categories,     only:   [:index]
    root to: 'homes#top'
    get      'homes/about'

  end

devise_for :members, skip: [:passwords] , controllers: {
  registrations: "member/registrations",
  sessions: 'member/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
