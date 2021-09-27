class AddTotalDurationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :total_duration, :integer, default: 0
  end
end
