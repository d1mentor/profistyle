Rails.application.routes.draw do
  
  devise_for :users
  
  devise_scope :user do
    get '/admin_panel/login', to: 'devise/sessions#new'
    get '/admin_panel/logout', to: 'devise/sessions#destroy'    
  end

  root "pages#home"
  get "/services", to: "pages#services"
  get "/portfolio", to: "pages#portfolio"
  get "/blog", to: "pages#blog"
  get "/contacts", to: "pages#contacts"
  get "/about_us", to: "pages#about"
  get "/services_ror", to: "pages#services_ror"
  get "/services_cms", to: "pages#services_cms"
  get "/services_seo", to: "pages#services_seo"
  get "/services_cmr", to: "pages#services_cmr"
  post "/contacts_form_send", to: "pages#contacts_form_send" 

  get 'admin_panel/home', to: "admin_panel#home"
  get 'admin_panel/posts', to: "admin_panel#posts"
  get 'admin_panel/new_post', to: "admin_panel#new_post"
  post 'admin_panel/create_post', to: "admin_panel#create_post"
  get 'admin_panel/post/:id', to: "admin_panel#show_post"
  get 'admin_panel/portfolio', to: "admin_panel#portfolio"
end
