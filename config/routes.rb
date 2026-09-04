Rails.application.routes.draw do
  resource :session
  resource :current_organization, only: :update
  resources :passwords, param: :token

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  resource :up, only: :show, controller: "rails/health"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  resource :dashboard, only: :show
  root to: "dashboards#show"

  resources :customers, only: %i[index show]
  resources :support_cases, only: %i[index show]
  resources :invoices, only: %i[index show]
  resources :subscriptions, only: %i[index show]
  resources :knowledge_documents, only: %i[index show]
end
