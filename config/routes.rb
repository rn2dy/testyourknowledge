Questions::Application.routes.draw do
  root :to => "home#index"           
  
  resources :surveys
  resources :published_surveys       
  resources :survey_participants
  
  resources :questions do
    post "save_all", :on => :collection
  end
  
  get   "builder/survey/:survey_id" => "home#builder"
  
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
end
