Cloudops::Engine.routes.draw do
  root to: 'application#show', as: :start

  resources :objects, only: %i[index show] do
    collection do
      get 'types'
    end
  end

  resources :asr, only: %i[show update destroy], param: :router_id do
    member do
      get 'interface_statistics'
    end
  end
end
