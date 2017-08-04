Rails.application.routes.draw do
  get '/:id' => 'url_generators#redirect_user'
  root 'url_generators#index'
  resources :url_generators
end

