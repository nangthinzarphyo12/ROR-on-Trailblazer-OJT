Rails.application.routes.draw do
  root 'posts#index'
  get 'posts/index'
  get 'posts/show'
  get 'posts/new'
  get 'posts/edit'
  patch 'posts/edit', to: 'posts#update'
  get 'posts/destroy'
  post 'posts/new', to: 'posts#create'
  post 'posts/store'
  get 'posts/search', to: 'posts#search_post'
  get 'posts/export', to: 'posts#export_csv'
  post 'posts/import', to: 'posts#import_csv'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'users/list', to: 'users#index'
  get 'users/new'
  post 'users/new', to: 'users#create'
  get 'users/show'
  get 'users/destroy'
  get 'users/edit'
  patch 'users/edit', to: 'users#update'

  get 'users/profile'
  get 'users/editPassword'
  patch 'users/editPassword', to: 'users#updatePassword'
  get 'users/editProfile'
  patch 'users/editProfile', to: 'users#updateProfile'

  get 'password/reset'
  post 'password/reset' , to: 'password#create'
  get 'password/reset/edit', to: 'password#edit'
  patch 'password/reset/edit' , to: 'password#update'

  get 'login', to: 'login#login'
  post 'login', to: 'login#attempt_login'
  get 'logout', to: 'login#logout'
  
end
