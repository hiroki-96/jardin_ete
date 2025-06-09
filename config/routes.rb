Rails.application.routes.draw do
  # ユーザー用ルート
  root to: 'orders#new'

  resources :orders, only: [:new, :create] do
    collection do
      post :confirm
      get :thanks
    end
  end

  # JavaScript用のサイズ取得エンドポイント（ユーザー注文フォーム用）
  resources :flower_types, only: [] do
    member do
      get :sizes # flower_types/:id/sizes のURLを定義（JS用）
    end
  end

  # 管理者用ルート
  namespace :admin do
    resources :flower_types, only: [:index, :show, :new, :create, :destroy] do
      resources :sizes, only: [:new, :create, :edit, :update, :destroy]
    end
  end
end