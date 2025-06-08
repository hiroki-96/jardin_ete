Rails.application.routes.draw do
  root to: 'orders#new'

  resources :orders, only: [:new, :create] do
    collection do
      post :confirm
      get :thanks
    end
  end

  resources :flower_types, only: [:new, :create, :edit, :update, :destroy]
end
