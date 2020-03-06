Rails.application.routes.draw do
  root to: 'power_generators#index'

  resources :home, only: %i[index]
  resources :power_generators, only: [:show]

  get 'freight', to: 'freights#freight_value', format: 'js'
end
