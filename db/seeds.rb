# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Folder.destroy_all
Note.destroy_all
NoteTag.destroy_all
Tag.destroy_all

ray = User.create!(first_name: "Raynaldo", last_name: "Sutisna", username: "raynaldo", email: "raynaldo_sutisna@example.com", password: "123", picture: "")
jake = User.create!(first_name: "Jake", last_name: "Short", username: "jake", email: "jake_short@example.com", password: "123", picture: "")

User.all.each do |user|
  user.folders.create!(name: "code")
  deleted = { title: "Deleted", body: "Deleted Notes", last_updated_at: DateTime.now(), archived: false, deleted: true, link: "", link_active: false }
  archived = { title: "Archived", body: "Archived Notes", last_updated_at: DateTime.now(), archived: true, deleted: false, link: "", link_active: false }
  deleted_and_archived = { title: "Deleted and Archived", body: "Deleted and Archived Notes", last_updated_at: DateTime.now(), archived: true, deleted: true, link: "", link_active: false }
  user.folders.first.notes.create!([deleted, archived, deleted_and_archived])
  user.folders.second.notes.create!([deleted, archived, deleted_and_archived])
end

puts "User Done!"
