Rails.application.routes.draw do
  resources :blogs do 
    collection do
      post :confirm
      get :index_1
      get :index_2
      get :index_4
    end
  end
end
