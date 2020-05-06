require 'rails_helper'

feature 'Admin view car models' do
  scenario 'successffuly' do
    fiat = Manufacturer.create!(name: 'Fiat')
    ford = Manufacturer.create!(name: 'Ford')
    hatch = CarCategory.create(name: 'Hatch médio', daily_rate: '20', car_insurance: '2189', 
                              third_party_insurance: '1800')

    CarModel.create!(name: 'Uno', year: 2020, motorization: '1.0', fuel_type: 'Flex', manufacturer: fiat, 
                     car_category: hatch)
    CarModel.create!(name: 'Ka', year: 2021, motorization: '1.0', fuel_type: 'Flex', manufacturer: ford, 
                     car_category: hatch)
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Modelos de carros'

    expect(page).to have_content('Fiat')
    expect(page).to have_content('Uno')
    expect(page).to have_content('2020')

    expect(page).to have_content('Ford')
    expect(page).to have_content('Ka')
    expect(page).to have_content('2021')
  end

  scenario 'and no car model' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Modelos de carros'

    expect(page).to have_content('Não a modelos de carros')
  end

  scenario 'and view details' do
    fiat = Manufacturer.create!(name: 'Fiat')
    hatch = CarCategory.create(name: 'Hatch médio', daily_rate: '20', car_insurance: '2189', 
                              third_party_insurance: '1800')

    CarModel.create!(name: 'Uno', year: 2020, manufacturer: fiat, 
                    motorization: '1.0', fuel_type: 'Flex', car_category: hatch)
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Modelos de carros'
    click_on 'Ver detalhes'

    expect(page).to have_content('Uno')
    expect(page).to have_content('Fabricantes: Fiat')
    expect(page).to have_content('Ano: 2020')
    expect(page).to have_content('Motor: 1.0')
    expect(page).to have_content('Combustivel: Flex')
    expect(page).to have_content('Categoria: Hatch médio')
    expect(page).to have_content('Diaria: R$ 20,00')
  end

  scenario 'and confirm model' do
    fiat = Manufacturer.create!(name: 'Fiat')
    ford = Manufacturer.create!(name: 'Ford')
    hatch = CarCategory.create!(name: 'Hatch médio', daily_rate: '20', car_insurance: '2189', 
                              third_party_insurance: '1800')

    uno = CarModel.create!(name: 'Uno', year: 2020, manufacturer: fiat, motorization: '1.0', 
                          fuel_type: 'Flex', car_category: hatch)
    CarModel.create!(name: 'Ka', year: 2021, motorization: '1.0', fuel_type: 'Flex', manufacturer: ford, 
                     car_category: hatch)
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Modelos de carros'
    within("tr#car-model-#{uno.id}") do
      click_on 'Ver detalhes'
    end

    expect(page).to have_content('Uno')
    expect(page).to have_content('Fabricantes: Fiat')
    expect(page).to have_content('Ano: 2020')
    expect(page).to have_content('Motor: 1.0')
    expect(page).to have_content('Combustivel: Flex')
    expect(page).to have_content('Categoria: Hatch médio')
    expect(page).to have_content('Diaria: R$ 20,00')

    expect(page).not_to have_content('Ford')
    expect(page).not_to have_content('Ka')
    expect(page).not_to have_content('2021')
  end
end