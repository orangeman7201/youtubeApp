class AddUserToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :user_id, :integer 
     add_index :movies, [:user_id, :created_at]
  end
end
