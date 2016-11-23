Rails.application.routes.draw do
  get 'kindergartens/index'

  get 'kindergartens/new'

  get 'kindergartens/show'

  get 'kindergartens/edit'

  resources :kindergartens
end
