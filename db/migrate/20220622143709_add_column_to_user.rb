class AddColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :limit, :integer
  end
end