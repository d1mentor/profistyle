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
  get "/services_ror", to: "pages#ror"
  get "/services_cms", to: "pages#cms"
  get "/services_seo", to: "pages#seo"
  get "/services_cmr", to: "pages#cmr"
end
