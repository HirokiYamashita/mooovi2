TechReviewSite::Application.routes.draw do

  root 'products#index'
  get 'products/search' => 'products#search'
  resources :products, only: :show do
    resources :reviews, only: [:new, :create]
  end
end
