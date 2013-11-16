Fsqcats::Application.routes.draw do
  scope "/:locale" do
    resources :categories do
      get 'compare', on: :collection
      get 'search', on: :collection
    end
  end

  get ':locale', to: 'categories#index', as: 'start'
  root 'categories#index'
end
