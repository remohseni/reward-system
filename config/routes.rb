Rails.application.routes.draw do
  post 'rewards/import'

  get 'welcome/index'
  root to: 'welcome#index'

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
