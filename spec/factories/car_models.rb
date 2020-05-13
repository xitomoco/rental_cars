FactoryBot.define do
  factory  :car_model do
    name { 'Cronos' }
    year { 2019 }
    fuel_type { 'Flex' }
    motorization { '1.3' }
    manufacturer
    car_category
  end
end