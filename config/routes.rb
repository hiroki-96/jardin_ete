Rails.application.routes.draw do
  # 管理者認証用ルート
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

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
    resources :flower_types do
      resources :sizes, only: [:new, :create, :edit, :update, :destroy]
    end

    resources :orders, only: [:index, :show, :destroy, :update]
    resources :business_days do
      collection do
        patch :set_closed_by_date
      end
    end
  end
end