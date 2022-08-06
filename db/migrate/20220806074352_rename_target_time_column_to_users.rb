class RenameTargetTimeColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :target_time, :limit
  end
end
