require 'rails_helper'

feature 'Admin view categories' do
  scenario 'successfuly' do
    car_category_hatch_compacto = CarCategory.create!(name: 'Hatch compacto', daily_rate: '40', car_insurance: '5200', 
                                                      third_party_insurance: '1800')
    car_category_hatch_medio = CarCategory.create!(name: 'Hatch médio', daily_rate: '20', car_insurance: '2189', 
                                                  third_party_insurance: '1800')

    visit root_path
    click_on 'Categorias de carros'

    expect(page).to have_content('Categoria Hatch médio')
    expect(page).to have_content('Diaria R$ 20,00')
    expect(page).to have_content('Categoria Hatch compacto')
    expect(page).to have_content('Diaria R$ 40,00')
    expect(page).not_to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'new car category details' do
    manufactuer = Manufacturer.create!(name: 'Fiat')
    car_category = CarCategory.create!(name: 'Hatch médio', daily_rate: '20', car_insurance: '2189', 
                                      third_party_insurance: '1800')
    car_model_uno = CarModel.create!(name: 'Uno', year: 2020, manufacturer: manufactuer, 
                                    motorization: '1.0', fuel_type: 'Flex', car_category: car_category)
    car_model_mobi = CarModel.create!(name: 'Mobi', year: 2019, manufacturer: manufactuer, 
                                      motorization: '1.0', fuel_type: 'Flex', car_category: car_category)

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Categoria Hatch médio'

    expect(page).to have_content('Categoria Hatch médio')
    expect(page).to have_content('Diaria R$ 20,00')
    expect(page).to have_content('Seguro do carro R$ 2,189,00')
    expect(page).to have_content('Seguro de terceiros R$ 1,800,00')
    expect(page).to have_link('Uno', href: car_model_path(car_model_uno))
    expect(page).to have_link('Mobi', href: car_model_path(car_model_mobi))
    expect(page).to have_link('Voltar', href: car_categories_path)
  end

  scenario 'and view filtered car models' do
    manufactuer = Manufacturer.create!(name: 'Fiat')
    car_category_hatch_medio = CarCategory.create!(name: 'Hatch médio', daily_rate: '20', car_insurance: '2189', 
                                                  third_party_insurance: '1800')
    car_category_hatch_compacto = CarCategory.create!(name: 'Hatch compacto', daily_rate: '40', 
                                                      car_insurance: '5200', third_party_insurance: '1800')
    car_model_uno = CarModel.create!(name: 'Uno', year: 2020, manufacturer: manufactuer, 
                                    motorization: '1.0', fuel_type: 'Flex', car_category: car_category_hatch_medio)
    car_model_mobi = CarModel.create!(name: 'Mobi', year: 2019, manufacturer: manufactuer, 
                                      motorization: '1.0', fuel_type: 'Flex', car_category: car_category_hatch_medio)
    car_model_argo = CarModel.create!(name: 'Argo', year: 2020, manufacturer: manufactuer, 
                                      motorization: '1.3', fuel_type: 'Flex', car_category: car_category_hatch_compacto)

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Categoria Hatch médio'

    save_page

    expect(page).to have_link('Uno', href: car_model_path(car_model_uno))
    expect(page).to have_link('Mobi', href: car_model_path(car_model_mobi))
    expect(page).not_to have_link('Argo')
  end

  scenario 'and no categories are created' do
    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and from index return to root' do
    visit root_path
    click_on 'Categorias'

    expect(page).to have_link('Voltar', href: root_path)
  end
end