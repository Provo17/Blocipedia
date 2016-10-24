Rails.application.routes.draw do
    
  resources :wikis
  
  resources :wikis, only: [] do             #needed to loop through wikis and collaborators to link the collaborator with the correct wiki id
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
  
    
  root 'welcome#index'
    
end
