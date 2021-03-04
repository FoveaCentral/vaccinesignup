Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :locations, only: nil do
    collection do
      get 'sync'
    end
  end
end
