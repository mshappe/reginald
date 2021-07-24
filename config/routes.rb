# == Route Map
#

require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.has_role? :admin } do
    mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get 'welcome/index'
  root to: 'welcome#index'

  resources :attendees, only: [:index, :show] do
    member { patch 'checkin' }
    member { patch 'uncheckin' }
    member { patch 'reissue' }
    member { patch 'eject' }

    collection { get 'importer' }
    collection { post 'import' }
  end

  resources :users, except: [:new, :create, :destroy] do
    member { put 'bless' }
    member { put 'curse' }
  end
end
