require 'rails_helper'

feature 'User search rental' do
  
  scenario 'successfully'do
    customer = Customer.create!(name: 'Fulano de almeida', email: 'teste@teste.com', cpf:'130.658.828-68')
    car_category = CarCategory.create!(name: 'Sedã', daily_rate: '40', car_insurance: '3500', 
                                      third_party_insurance: '1000')
    rental = Rental.create!(start_date: 1.day.from_now, end_date: 5.days.from_now, customer: customer, 
                      car_category: car_category)
    other_rental = Rental.create!(start_date: 3.day.from_now, end_date: 5.days.from_now, customer: customer, 
                            car_category: car_category)
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'

    fill_in 'Código', with: rental.code
    click_on 'Buscar'

    expect(page).to have_content(rental.code)
    expect(page).not_to have_content(other_rental.code)
  end

  scenario 'and cannot be blank'do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'

    fill_in 'Código', with: ''
    click_on 'Buscar'

    expect(page).to have_content('Busca não pode ficar em branco')
  end

  scenario 'and code cannot found'do
    customer = Customer.create!(name: 'Fulano de almeida', email: 'teste@teste.com', cpf:'130.658.828-68')
    car_category = CarCategory.create!(name: 'Sedã', daily_rate: '40', car_insurance: '3500', 
                                      third_party_insurance: '1000')
    rental = Rental.create!(start_date: 1.day.from_now, end_date: 5.days.from_now, customer: customer, 
                      car_category: car_category)
    other_rental = Rental.create!(start_date: 3.day.from_now, end_date: 5.days.from_now, customer: customer, 
                            car_category: car_category)
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Locações'

    fill_in 'Código', with: 'LK5DF'
    click_on 'Buscar'

    expect(page).to have_content("Nenhum código foi em contrado para: LK5DF")
  end
end