require 'rails_helper'

feature 'User start rental' do

  scenario 'successfully' do
    customer = Customer.create!(name: 'Fulano de almeida', email: 'teste@teste.com', cpf:'130.658.828-68')
    car_category = create(:car_category)
    manufacturer = create(:manufacturer, name: 'Fiat')
    car_model = create(:car_model, manufacturer: manufacturer, car_category: car_category)
    car = Car.create!(license_plate: 'ACB1234', color: 'Branco', car_model: car_model, milage: 0)
    rental = Rental.create!(start_date: 1.day.from_now, end_date: 5.days.from_now, customer: customer, 
                            car_category: car_category)
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit search_rentals_path(q: rental.code)
    click_on 'Iniciar'
    select car.license_plate, from: 'Carro'
    click_on 'Confirmar locação'

    expect(page).to have_content(I18n.l Time.now, format: :long)
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content('Em progresso')
    expect(page).to have_content(user.email)
  end

  scenario 'and from customer page' do
    customer = Customer.create!(name: 'Fulano de almeida', email: 'teste@teste.com', cpf:'130.658.828-68')
    car_category = create(:car_category)
    manufacturer = create(:manufacturer, name: 'Fiat')
    car_model = create(:car_model, manufacturer: manufacturer, car_category: car_category)
    car = Car.create!(license_plate: 'ACB1234', color: 'Branco', car_model: car_model, milage: 0)
    rental = Rental.create!(start_date: 1.day.from_now, end_date: 5.days.from_now, customer: customer, 
                            car_category: car_category)
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit customer_path(customer)
    click_on 'Iniciar'
    select car.license_plate, from: 'Carro'
    click_on 'Confirmar locação'

    expect(page).to have_content(I18n.l Time.now, format: :long)
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content('Em progresso')
    expect(page).to have_content(user.email)
  end
end