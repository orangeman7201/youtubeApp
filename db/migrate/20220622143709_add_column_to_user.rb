class AddColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :target_time, :string
  end
end
