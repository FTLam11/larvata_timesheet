LarvataTimesheet::Engine.routes.draw do
  resources :offdays, defaults: { format: :json }, only: [:index, :create, :update, :destroy], param: :date_id
end
