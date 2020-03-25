Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :rounds do
    resources :round_plays, only: [:new, :create, :show]
  end

  post '/rounds/new/questions', to: 'rounds#questions', as: 'new_round_questions'
  
  resources :games do
    resources :game_plays, only: [:new, :create]
    get '/game_plays/start', to: 'game_plays#start'
    get '/game_plays/results', to: 'game_plays#results'
  end

  post '/games/new/rounds', to: 'games#rounds', as: 'new_game_rounds'

  root 'session#index'
  get '/login', to: 'session#new', as: 'login'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy', as: 'logout'

  resources :round_groups

  post '/round_groups/:round_id/save', to: 'round_groups#save', as: 'save_round'
  delete '/round_groups/:round_group_round_id/remove', to: 'round_groups#remove', as: 'remove_round'
end
