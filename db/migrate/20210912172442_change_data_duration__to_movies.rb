class ChangeDataDurationToMovies < ActiveRecord::Migration[6.1]
  def up
    # 環境ごとにマイグレーションを分ける
    if Rails.env.development? || Rails.env.test?
      change_column :movies, :duration, :integer
    else Rails.env.production?
      # 本番環境はusingオプションを追加
      change_column :movies, :duration, 'integer USING CAST(duration AS integer)'
    end
  end

  def down
    change_column :movies, :duration, :integer
  end
end
