FactoryBot.define do
  factory :content do
    body { "MyText" }
    user { nil }
    article { nil }
  end
end
