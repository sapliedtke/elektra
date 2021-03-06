KeyManager::Engine.routes.draw do

  resources :secrets, only: [:index, :show, :new, :create, :destroy] do
    get 'type_update', :on => :collection
    get 'payload', :on => :member
  end

  resources :containers, only: [:index, :show, :new, :create, :destroy]

end
