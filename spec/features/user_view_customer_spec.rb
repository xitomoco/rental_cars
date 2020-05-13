require 'rails_helper'

feature 'User view customer' do
  scenario 'and view multiple customers' do
    customer = Customer.create!(name: 'Fulano de Almeida', cpf: '470.479.633-75', email: 'funalo@teste.com')
    other_customer = Customer.create!(name: 'Cicrano de Almeida', cpf: '470.479.633-75', 
                                      email: 'funalo@teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'

    expect(page).to have_content(customer.name)
    expect(page).to have_content(other_customer.name)
  end

  scenario 'and view customer details' do
    customer = Customer.create!(name: 'Fulano de Almeida', cpf: '470.479.633-75', email: 'funalo@teste.com')
    other_customer = Customer.create!(name: 'Cicrano de Almeida', cpf: '470.479.633-75', 
                                      email: 'funalo@teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'
    click_on customer.name

    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.cpf)
    expect(page).to have_content(customer.email)
    expect(page).not_to have_content(other_customer.name)
  end

  scenario 'without rentals' do
    customer = Customer.create!(name: 'Fulano de Almeida', cpf: '470.479.633-75', email: 'funalo@teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'
    click_on customer.name

    expect(page).not_to have_link('Iniciar')
  end

  scenario 'without customers' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'

    expect(page).to have_content('Nenhum cliente cadastrado')
  end
end