AwesomeEvents::Application.routes.draw do
  root to: 'welcome#index'
  get '/auth/:provider/callback' => 'sessions#create'
end
