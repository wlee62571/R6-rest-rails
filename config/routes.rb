# Rails.application.routes.draw do
#   devise_for :users
#   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
# end

Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  get '/test', to: 'test#show'
end