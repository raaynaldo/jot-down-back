Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post "/login", to: "auth#create"

      post "/users", to: "users#create"
      get "/profile", to: "users#show"

      get "/get_folders", to: "folders#get_folders"

      get "/get_tags", to: "tags#get_tags"

      get "/get_notes_by_folder/:id", to: "notes#get_notes_by_folder"
      get "/get_notes_in_archived/", to: "notes#get_notes_in_archived"
      get "/get_notes_in_trash/", to: "notes#get_notes_in_trash"
      get "/get_notes_by_tag/:id", to: "notes#get_notes_by_tag"
    end
  end
end
