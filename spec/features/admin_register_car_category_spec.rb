require 'rails_helper'

feature 'Admin register car category' do
  scenario 'from index page' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias'

    expect(page).to have_link('Cadastrar categoria', href: new_car_category_path)
  end

  scenario 'successfuly' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias'
    click_on 'Cadastrar categoria'

    fill_in 'Nome', with: 'Nome da categoria'
    fill_in 'Taxa diaria', with: '99.9'
    fill_in 'Seguro do automóvel', with: '99.9'
    fill_in 'Seguro de terceiros', with: '99.9'
    click_on 'Enviar'

    expect(page).to have_content('Nome da categoria')
    expect(page).to have_content('99,9')
    expect(page).to have_content('99,9')
    expect(page).to have_content('99,9')
  end

  scenario 'and check all create fields are fill' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Categorias'
    click_on 'Cadastrar categoria'

    fill_in 'Nome', with: ''
    fill_in 'Taxa diaria', with: ''
    fill_in 'Seguro do automóvel', with: ''
    fill_in 'Seguro de terceiros', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da categoria')
  end

  scenario 'and check return link in page_new' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user
    
    visit root_path
    click_on 'Categorias'
    click_on 'Cadastrar categoria'

    expect(page).to have_link('Voltar', href: car_categories_path)
  end
end