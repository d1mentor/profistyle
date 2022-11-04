Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_err'
  get 'sitemap/sitemap'
  
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  devise_for :users
  
  devise_scope :user do
    get '/admin_panel/login', to: 'devise/sessions#new'
    get '/admin_panel/logout', to: 'devise/sessions#destroy'    
    post '/admin_panel/create_message', to: "admin_panel#create_message"
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

  get '/admin_panel/', to: "admin_panel#home"
  get '/admin_panel/posts', to: "admin_panel#posts"
  get '/admin_panel/posts_base', to: "admin_panel#posts_base"
  get '/admin_panel/new_post', to: "admin_panel#new_post"
  post '/admin_panel/create_post', to: "admin_panel#create_post"
  get '/blog/post/:id', to: "pages#show_post"
  get '/admin_panel/post/:id/edit', to: "admin_panel#edit_post"
  post '/admin_panel/post/:id/update', to: "admin_panel#update_post"
  post '/admin_panel/post/:id/destroy', to: "admin_panel#destroy_post"
  get '/admin_panel/portfolio', to: "admin_panel#portfolio"
  get '/admin_panel/messages', to: "admin_panel#messages"
  get '/admin_panel/message/:id', to: "admin_panel#message"
  get '/admin_panel/messages/destroy_all_spam', to: "admin_panel#spam_destroy"
  get '/admin_panel/message/swap_spam_attr/:id', to: "admin_panel#swap_spam_attr"

  get '/sitemap', to: 'sitemap#sitemap', defaults: { format: 'xml' }
end
