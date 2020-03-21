Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users, 
              path: '', 
              path_names: {sign_up: 'cadastrar', sign_in: 'entrar', edit: 'perfil', sign_out: 'sair'},
              controllers: {omniauth_callbacks: 'omniauth_callbacks', sessions: 'sessions',  registrations: 'registrations' }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end