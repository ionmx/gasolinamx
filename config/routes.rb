Rails.application.routes.draw do
  scope path: '/api/v1' do
    get 'near', to: 'places#near'
    get 'area', to: 'places#area'
  end
end
