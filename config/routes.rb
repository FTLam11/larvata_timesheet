LarvataTimesheet::Engine.routes.draw do
  resources :offdays, defaults: { format: :json }, only: [:index, :create], param: :date_id
  resources :activities, defaults: { format: :json }, only: [:index, :create, :update, :destroy]
  resources :calendars, defaults: { format: :json }, only: [:index, :post, :destroy]
  resources :calendar_months, defaults: { format: :json }, only: [:create, :show, :update], param: :date_id
end
