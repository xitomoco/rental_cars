require 'rails_helper'

feature 'User register customer' do
  scenario 'from index page' do
    visit root_path
    click_on 'Clientes'

    expect(page).to have_link('Cadastrar cliente', href: new_customer_path)
  end

  scenario 'successfuly' do
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar cliente'

    fill_in 'Nome', with: 'Nome do cliente'
    fill_in 'CPF', with: 'CPF do cliente'
    fill_in 'Email', with: 'Email do cliente'
    click_on 'Enviar'

    expect(page).to have_content('Nome do cliente')
    expect(page).to have_content('CPF do cliente')
    expect(page).to have_content('Email do cliente')
  end

  scenario 'and check return link' do
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar cliente'

    expect(page).to have_link('Voltar', href: customers_path)
  end

  scenario 'and check all fields are fill' do 
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
