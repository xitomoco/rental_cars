require 'rails_helper'

RSpec.describe Rental, type: :model do
  it 'shold generate a code on create' do
    customer = Customer.create!(name: 'Fulano de almeida', email: 'teste@teste.com', cpf:'130.658.828-68')
    car_category = CarCategory.create!(name: 'Sedã', daily_rate: '40', car_insurance: '3500', 
                                       third_party_insurance: '1000')
    rental = Rental.new(start_date: 1.day.from_now, end_date: 5.days.from_now, customer: customer, 
                       car_category: car_category)

    rental.save

    expect(rental.code).not_to be_blank
  end
end
