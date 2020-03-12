Rails.application.routes.draw do
  resources :exrecs do
    resources :exgoods
    resources :exdlvs
  end
  get 'more_info', to: 'people#more'
  get 'delv_info', to: 'delivers#delv'
  get 'more_info_lay', to: 'layrecs#morelay'
  root to:'people#index'
  devise_for :users
  resources :people do
    resources :goods
    resources :pays
    resources :delivers
  end
  resources :layrecs do
    resources :goodlays
    resources :paylays
    resources :deliverlays
  end
end
