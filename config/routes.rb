Rails.application.routes.draw do
  root to: 'power_generators#index'

  resources :home, only: %i[index]
  resources :power_generators, only: [:show]

  get 'advanced-search', to: 'power_generators#advanced_search', format: 'js'
  get 'freight', to: 'freights#freight_value', format: 'js'
  get 'kwp-filter', to: 'power_generators#filter_kwp', format: 'js'
  get 'price-filter', to: 'power_generators#filter_price', format: 'js'
  get 'simple-search', to: 'power_generators#simple_search', format: 'js'
end
