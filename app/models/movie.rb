class Movie < ApplicationRecord
  belongs_to :user
  # validates :user_id, inclusion: { } これは後でUserModel作ったときに設定する
  # validates :url, exclusion: { in: nil, message: "空欄です" }
  # validates :duration, exclusion: { in: nil, message: "空欄です" }
  # validates :title, exclusion: { in: nil, message: "空欄です" }
  # # validates :comment, exclusion: { in: [nil] }入ってなくても保存できる
  # validates :date, exclusion: { in: nil, message: "空欄です" }

  scope :target_date, -> (dateStatus) {
    target_date = Date.today + dateStatus.to_i.day
      where(date: target_date.beginning_of_day .. target_date.end_of_day)
  }
end