Rails.application.routes.draw do
  scope path: '/api/v1' do
    get 'near', to: 'places#near'
  end
end
