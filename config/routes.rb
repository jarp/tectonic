Rails.application.routes.draw do

  resources :tours
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  get 'play/map' => 'play#map', as: :map
  get 'play/table' => 'play#table', as: :current_table
  get 'play/timeline' => 'play#timeline', as: :timeline
  get '/play/:id' => 'play#set', as: :play_game
  get '/play' => 'play#index', as: :current_game

  get '/dashboard' => 'administrator#index', as: :dashboard

  root 'welcome#index'
  get '/map/' => 'welcome#map'
  get 'about' => 'welcome#about'
  get 'invite' => 'invite#index', as: :invites
  post 'invite' => 'invite#create', as: :send_invite
  get 'invite/:token' => 'invite#accept', as: :accept_invite
  post 'invite/join' => 'invite#accept', as: :join_game

  get 'login' => 'account#index', as: :login
  get 'logout' => 'account#logout', as: :logout

  get '/auth/google'
  get '/auth/:provider/callback', to: 'account#callback'

  post 'finds/lock/' => 'finds#lock', as: :lock
  delete 'finds/lock/:code' => 'finds#unlock', as: :unlock

  resources :finds do
    collection do
      post 'clear' => 'finds#clear', as: :clear
      get 'avatar/:plate_id' => 'finds#avatar', as: :avatar
    end

end
  post 'finds/:player_id' => 'finds#create'

  resources :game_players
  resources :players
  resources :games do
    member do
      get 'complete' => 'games#complete', as: :complete
      get 'results' => 'games#results', as: :results
    end
  end
  resources :plates
  resources :game_types
end
