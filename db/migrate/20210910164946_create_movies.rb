class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.integer :user_id
      t.string :url
      t.time :duration
      t.string :title
      t.text :comment
      t.datetime :date

      t.timestamps
    end
  end
end
