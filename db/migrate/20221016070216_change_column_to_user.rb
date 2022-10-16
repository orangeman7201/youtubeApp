class ChangeColumnToUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :total_duration, :integer
    add_column :users, :uuid, :string
  end
end
