Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :rounds do
    resources :round_plays, only: [:new, :create, :show]
  end

  # get '/play-rounds/:id', to: 'round_plays#play', as: 'play_round'
  # post '/play-rounds/:id', to: 'round_plays#score'
  # get '/play-rounds/:id/results', to: 'round_plays#results', as: 'results_play_round'
end
