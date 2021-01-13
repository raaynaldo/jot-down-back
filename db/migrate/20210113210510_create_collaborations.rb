class CreateCollaborations < ActiveRecord::Migration[6.1]
  def change
    create_table :collaborations do |t|
      t.integer :note_id
      t.integer :user_id

      t.timestamps
    end
  end
end
