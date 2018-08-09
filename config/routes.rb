Rails.application.routes.draw do

  resources :projects do
    get :regres, on: :collection
    member do
      get :active
      get :deactive
    end
    resources :scenarios do
      member do
        get :run
      end
      get :go, on: :collection
    end
  end

  # Devise routes
  # devise_for :users, controllers: { seesions: 'users/sessions' }
  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'projects#index'

  get 'dm/svn_merge_trunk/:branch_name', to: 'dm#svn_merge_trunk'
  get 'dm/svn_rm_branch/:branch_name', to: 'dm#svn_rm_branch'
  get 'dm/svn_cp_branch/:branch_name', to: 'dm#svn_cp_branch'

end
