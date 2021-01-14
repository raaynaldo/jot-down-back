class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string :title
      t.string :body
      t.datetime :last_updated_at
      t.boolean :archived
      t.boolean :deleted
      t.string :link
      t.boolean :link_active
      t.integer :folder_id

      t.timestamps
    end
  end
end
