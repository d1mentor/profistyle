Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"
  get "/services", to: "pages#services"
  get "/portfolio", to: "pages#portfolio"
  get "/blog", to: "pages#blog"
  get "/contacts", to: "pages#contacts"
  get "/about_us", to: "pages#about"
end
