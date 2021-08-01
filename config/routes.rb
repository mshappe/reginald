# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get 'welcome/index'
  root to: 'welcome#index'

  resources :attendees, except: :destroy do
    member { patch 'checkin' }
    member { patch 'uncheckin' }
    member { patch 'reissue' }
    member { patch 'eject' }

    collection { get 'importer' }
    collection { post 'import' }
  end

  resources :attendee_notes, only: %i[new create]

  resources :users, except: %i[new create destroy] do
    member { put 'bless' }
    member { put 'curse' }
  end
end
