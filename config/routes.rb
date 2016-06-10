Rails.application.routes.draw do
    
  resources :wikis
  
  resources :wikis, only: [] do
    resources :collaborators, only: [] do
      member do
        put :delete
      end
    end
  end  
  
  resources :charges, only: [:new, :create]  

  devise_for :users
  
  resources :users, only: [] do
    member do
      put :downgrade
    end
  end
  
    
  root 'wikis#index'
    
end
