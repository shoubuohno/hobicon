Rails.application.routes.draw do

  scope module: 'user' do
    devise_for :users, controllers: {
      sessions: 'user/users/sessions',
      registrations: 'user/users/registrations',
      passwords: 'user/users/passwords'
    }
  end

  scope module: 'user' do
   resources :users, only: [:index, :show, :edit, :update]
   resources :posts do
   	resources :post_comments, only: [:create, :destroy]
   end
  end


end
