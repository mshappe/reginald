# == Route Map
#

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get 'welcome/index'
  root to: 'welcome#index'

  resources :attendees, only: [:index, :show] do
    member { put 'checkin' }
    member { put 'uncheckin' }
    member { put 'reissue' }
    member { put 'eject' }
  end

  resources :users, except: [:new, :create, :destroy] do
    member { put 'bless' }
    member { put 'curse' }
  end
end
