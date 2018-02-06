Rails.application.routes.draw do



    namespace :api do
        namespace :v1 do
            mount_devise_token_auth_for 'User', at: 'auth'
            resources :companies
            resources :products, only: [:create, :update, :destroy]
            resources :subscribers
        end
    end

end
