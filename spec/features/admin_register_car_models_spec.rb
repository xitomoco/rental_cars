require 'rails_helper'

feature'Admin register car models' do

  scenario 'successfully' do
    manufactuer = Manufacturer.create!(name: 'Ford')
    car_category = CarCategory.create!(name: 'Hatch médio', daily_rate: '20', car_insurance: '2189', 
                                       third_party_insurance: '1800')

    visit root_path
    click_on 'Modelos de carros'
    click_on 'Cadastrar modelo'

    fill_in 'Nome',	with: 'Ka' 
    fill_in 'Ano',	with: '2021'
    select 'Ford', from: 'Fabricante'
    fill_in 'Motor', with: '1.0'
    fill_in 'Combustivel', with: 'Flex'
    select 'Hatch médio', from: 'Categoria'
    click_on 'Enviar'

    expect(page).to have_content('Detalhe do modelo Ka')
    expect(page).to have_content('Fabricantes: Ford')
    expect(page).to have_content('Categoria: Hatch')
    expect(current_path).to eq(car_model_path(CarModel.last))
  end

  scenario 'and fill in all fields' do
    visit new_car_model_path
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')
    expect(page).to have_content('Motor não pode ficar em branco')
    expect(page).to have_content('Combustivel não pode ficar em branco')
    expect(page).to have_content('Fabricante é obrigatório(a)')
    expect(page).to have_content('Categoria é obrigatório(a)')
  end
end