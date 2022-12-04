class Movie < ApplicationRecord
  belongs_to :user
  # validates :user_id, inclusion: { } これは後でUserModel作ったときに設定する
  # validates :url, exclusion: { in: nil, message: "空欄です" }
  # validates :duration, exclusion: { in: nil, message: "空欄です" }
  # validates :title, exclusion: { in: nil, message: "空欄です" }
  # # validates :comment, exclusion: { in: [nil] }入ってなくても保存できる
  # validates :date, exclusion: { in: nil, message: "空欄です" }

  scope :today, -> {
    today = Date.today
    where(created_at: today.beginning_of_day .. today.end_of_day)
  }

  scope :this_week, -> {
    to = Date.today 
    from = Date.today - ( 7 ).day ## 7: 一週間
    where(created_at: from.beginning_of_day .. to.end_of_day)
  }
end