require 'rails_helper'

feature 'Admin view categories' do
  scenario 'successfuly' do
    CarCategory.create(name: 'Nome da categoria', daily_rate: '99.99', 
                      car_insurance: '99.99', third_party_insurance: '99.99')

    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Nome da categoria')
    expect(page).to have_content('99.99')
    expect(page).to have_content('99.99')
    expect(page).not_to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and no categories are created' do
    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and from index return to root' do
    CarCategory.create(name: 'Nome da categoria', daily_rate: '99.99', 
                      car_insurance: '99.99', third_party_insurance: '99.99')

    visit root_path
    click_on 'Categorias'

    expect(page).to have_link('Voltar', href: root_path)
  end
end