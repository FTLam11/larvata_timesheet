LarvataTimesheet::Engine.routes.draw do
  resources :offdays, defaults: { format: :json }, only: [:index]
end
