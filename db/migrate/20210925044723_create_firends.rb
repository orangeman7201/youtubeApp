class CreateFirends < ActiveRecord::Migration[6.1]
  def change
    create_table :firends do |t|
      t.integer :user_id
      t.integer :firend_user_id

      t.timestamps
    end
  end
end
