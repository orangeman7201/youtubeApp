class RemoveCommentFromMovies < ActiveRecord::Migration[6.1]
  def change
    remove_column :movies, :comment, :string
  end
end
