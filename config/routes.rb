Rails.application.routes.draw do
  # rootパス
  root 'public/homes#top'

  # 管理者用サイトのルーティング
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }

  namespace :admin do
    get 'homes/top' => 'homes#top', as:'top'
    resources :items
    resources :genres
    resources :customers
    resources :orders, only:[:index,:show,:update]
    resources :order_items, only:[:update]
  end

  # 顧客用サイトのルーティング
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }

  namespace :public do
    get '/top' => 'homes#top', as:'customer_top'
    get '/about' => 'homes#about'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all' #カート内アイテムの全削除用
    resources :items, only:[:index,:show,:new] do
      get :search, on: :collection #ジャンル検索機能用
    end
    resources :cart_items
    post '/orders/session' => 'orders#session_create'
    get '/orders/confirm' => 'orders#confirm'
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/thanks' => 'orders#thanks'
    patch '/customers/withdrawal' => 'customers#destroy'
    get '/customers/withdrawal' => 'customers#withdrawal'
    resources :orders, only:[:new,:create,:index,:show]
    resource :customers, only:[:show ,:edit,:update]
    resources :addresses, only:[:index, :edit, :destroy, :create, :update]
  end
end
