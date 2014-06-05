Rails.application.routes.draw do
  root 'pusher#index'

  get    '/chat_rooms',         to: 'chat_rooms#index'
  post   '/chat_rooms',         to: 'chat_rooms#create'
  get    '/chat_rooms/:id',     to: 'chat_rooms#room'
  delete '/chat_rooms/:id',     to: 'chat_rooms#destroy'
  post   '/chat_rooms/new',     to: 'chat_rooms#new'
  post   '/chat_rooms/clear',   to: 'chat_rooms#clear'
  post   '/chat_rooms/message', to: 'chat_rooms#message'

  post '/pusher/create',  to: 'pusher#create'
  post '/pusher/clear',   to: 'pusher#clear'
end
