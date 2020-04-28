require 'rails_helper'

feature 'Admin view categories' do
  scenario 'successfuly' do
    CarCategory.create(name: 'Hatch médio', daily_rate: '20', 
                      car_insurance: '2189', third_party_insurance: '1800')

    visit root_path
    click_on 'Categorias de carros'

    expect(page).to have_content('Categoria Hatch médio')
    expect(page).to have_content('Diaria R$ 20,00')
    expect(page).not_to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'new car category details' do
    CarCategory.create(name: 'Hatch médio', daily_rate: '20', 
                      car_insurance: '2189', third_party_insurance: '1800')

    visit root_path
    click_on 'Categorias de carros'
    click_on 'Categoria Hatch médio'

    expect(page).to have_content('Categoria Hatch médio')
    expect(page).to have_content('Diaria R$ 20,00')
    expect(page).to have_content('Seguro do carro R$ 2,189,00')
    expect(page).to have_content('Seguro de terceiros R$ 1,800,00')
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