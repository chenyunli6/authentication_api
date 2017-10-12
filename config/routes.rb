Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'sms/code', to: 'sms_messages#create'
  post 'signup', to: 'users#create'
  post 'login', to: 'authentication#create'
  resource :passwords, only: :create
end
