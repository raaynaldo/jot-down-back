Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post "/login", to: "auth#create"

      post "/users", to: "users#create"
      get "/profile", to: "users#show"

      get "/get_folders", to: "folders#get_folders"
      post "create_folder", to: "folders#create_folder"
      patch "update_folder", to: "folders#update_folder"

      get "/get_tags", to: "tags#get_tags"

      get "/get_notes", to: "notes#get_notes"
      get "/get_note/:id", to: "notes#get_note"
      patch "/save_note/", to: "notes#save_note"
      post "/add_note/", to: "notes#add_note"
      patch "/archive_note", to: "notes#archive_note"
      patch "/delete_note", to: "notes#delete_note"
      patch "/move_note", to: "notes#move_note"
      delete "/delete_permanently_note/:id", to: "notes#delete_permanently_note"

      post "/add_note_tag", to: "note_tags#add_note_tag"
      post "/remove_note_tag", to: "note_tags#remove_note_tag"
    end
  end
end
