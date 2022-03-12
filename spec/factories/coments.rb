FactoryBot.define do
  factory :coment do
    body { "MyText" }
    user { nil }
    article { nil }
  end
end
