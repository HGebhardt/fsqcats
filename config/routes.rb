Fsqcats::Application.routes.draw do
  get 'categories/:id', to: 'categories#redirect', id: /\d+/
  get 'categories/search', to: 'categories#search'
  scope "/:locale" do
    get 'categories/:id', to: 'categories#redirect', id: /\d+/
    resources :categories do
      get 'compare', on: :collection
      get 'search', on: :collection
    end
  end

  get ':locale', to: 'categories#index', as: 'start'
  root 'categories#index'
end
