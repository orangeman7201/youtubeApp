class Movie < ApplicationRecord
  # validates :user_id, inclusion: { } これは後でUserModel作ったときに設定する
  validates :url, exclusion: { in: nil, message: "空欄です" }
  validates :duration, exclusion: { in: nil, message: "空欄です" }
  validates :title, exclusion: { in: nil, message: "空欄です" }
  # validates :comment, exclusion: { in: [nil] }入ってなくても保存できる
  validates :date, exclusion: { in: nil, message: "空欄です" }
end
