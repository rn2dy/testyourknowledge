Questions::Application.routes.draw do
  root :to => "home#index"           
  
  resources :surveys
  
  resources :questions
  
  get "builder" => "home#builder"

  

  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
end
