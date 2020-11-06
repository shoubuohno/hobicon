Rails.application.routes.draw do

  scope module: 'user' do
    devise_for :users, controllers: {
      sessions: 'user/users/sessions',
      registrations: 'user/users/registrations',
      passwords: 'user/users/passwords'
    }
  end

  scope module: 'user' do
  	root :to => 'tops#top'
    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get :following, :followers
      end
    end
    resources :relationships, only: [:create, :destroy]
    resources :posts do
   	  resources :post_goods, only: [:create, :destroy]
   	  resources :post_comments, only: [:create, :destroy]
   end
  end


end
