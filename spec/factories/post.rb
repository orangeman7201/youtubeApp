FactoryBot.define do
  factory :post do
    comment { "コメント" }
    association :user, strategy: :build
  end
end