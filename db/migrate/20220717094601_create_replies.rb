class CreateReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :replies do |t|
      t.references :user
      t.references :post
      t.string    :reply
      t.timestamps
    end
  end
end
