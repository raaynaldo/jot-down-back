class ChangeDataTypeForBodyInNote < ActiveRecord::Migration[6.1]
  def change
    change_column :notes, :body, :text
  end
end
