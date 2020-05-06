require 'rails_helper'

feature 'User register customer' do
  scenario 'from index page' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'

    expect(page).to have_content('Nenhum cliente cadastrado')
    expect(page).to have_link('Cadastrar cliente', href: new_customer_path)
  end

  scenario 'successfuly' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar cliente'

    fill_in 'Nome', with: 'Nome do cliente'
    fill_in 'CPF', with: '630.961.353-71'
    fill_in 'Email', with: 'chmleave@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('Nome do cliente')
    expect(page).to have_content('630.961.353-71')
    expect(page).to have_content('chmleave@gmail.com')
  end

  scenario 'and check return link' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar cliente'

    expect(page).to have_link('Voltar', href: customers_path)
  end

  scenario 'and check all fields are fill' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user
    
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar cliente'

    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Email', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados do cliente')
  end
end
