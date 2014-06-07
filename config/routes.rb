Rails.application.routes.draw do
  root 'chat_rooms#index'

  get    '/chat_rooms',         to: 'chat_rooms#index'
  post   '/chat_rooms',         to: 'chat_rooms#create'
  get    '/chat_rooms/:id',     to: 'chat_rooms#room'
  delete '/chat_rooms/:id',     to: 'chat_rooms#destroy'
  post   '/chat_rooms/new',     to: 'chat_rooms#new'
  post   '/chat_rooms/clear',   to: 'chat_rooms#clear'
  post   '/chat_rooms/message', to: 'chat_rooms#message'

  get    '/users',     to: 'users#index'
  post   '/users',     to: 'users#create'
  get    '/signup',    to: 'users#new'
  delete '/users/:id', to: 'users#destroy'

  get  '/signin', to: 'user_sessions#new'
  post '/signin', to: 'user_sessions#create'

  get '*path', to: 'application#render_404'
end
