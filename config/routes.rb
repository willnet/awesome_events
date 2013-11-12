AwesomeEvents::Application.routes.draw do
  root to: 'welcome#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout
  resources :events do
    resources :tickets
  end
  match '*path' => 'application#error404', via: :all
end
