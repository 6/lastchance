RailsBoilerplate::Application.routes.draw do
  post "validate" => "home#confirm_email", :as => "confirm"
  get "confirm/:salt" => "home#validate_email"
  get "choose" => "home#choose", :as => "choose"
  post "chosen" => "home#process_choices", :as => "chosen"
  get "admin/users/:action" => "admin/users#:action", :as => "admin_user"
  root :to => 'home#index'
end
