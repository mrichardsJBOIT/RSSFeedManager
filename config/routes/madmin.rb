# Below are the routes for madmin
namespace :madmin do
  resources :entries
  resources :feeds do
    member do
      post :fetch_entries
    end
  end
  root to: "dashboard#show"
end
