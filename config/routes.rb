Rails.application.routes.draw do
  devise_for :users

  resources :recipes, only: %i[index show new create destroy]
  resources :foods, only: %i[index new create destroy]

  get '/public_recipes', to: 'recipes#public_recipes'
  get '/shopping_list', to: 'shopping_list#index'
  get '/recipes/:id/new_ingredient', to: 'recipes#new_ingredient', as: 'recipes_add_ingredient'
  post '/recipes/:id/new_ingredient', to: 'recipes#add_ingredient', as: 'recipes_add_ingredient_post'

  # root '/recipes#index'
end
