FactoryBot.define do
  factory :item do
    name           {"テスト商品"}
    message        {"テストテストテスト"}
    category_id    {1}
    status_id      {1}
    charge_id      {1}
    schedule_id    {1}
    prefecture_id  {1}
    price          {1000}
    association :user
  end
end
