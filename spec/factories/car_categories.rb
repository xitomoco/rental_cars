FactoryBot.define do
  factory :car_category do
    name { 'Sedã' }
    daily_rate { 40 }
    car_insurance { 3500 }
    third_party_insurance { 1000 }
  end
end