FactoryBot.define do
  factory :movie do
    title { "動画テスト" }
    association :user, strategy: :build
  end
end
