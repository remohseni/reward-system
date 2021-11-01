Rails.application.routes.draw do
  post 'rewards/import'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
