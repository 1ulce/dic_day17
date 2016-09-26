Rails.application.routes.draw do
  resources :blogs do
    post '/confirm', action: 'confirm' 
    collection do
      get :index_1
      get :index_2
      get :index_3
      get :index_4
    end
  end
  root 'blogs#index'
end
