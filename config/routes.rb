Rails.application.routes.draw do
  root to: 'games#new'
  get 'reset', to: 'games#reset'
  post 'score', to: 'games#score'
end
