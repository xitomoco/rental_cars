require 'rails_helper'

feature 'User search customer' do
  
  scenario 'by name' do
    other_customer = Customer.create!(name: 'Outro Cliente', cpf: '525.376.945-54', email: 'teste@teste.com')
    customer = Customer.create!(name: 'Nome cliente', cpf: '637.421.553-26', email: 'teste@teste.com')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Clientes'

    save_page

    fill_in 'Busca', with: 'Nome cliente'
    click_on 'Buscar'

    expect(page).to have_content(customer.name)
    expect(page).not_to have_content(other_customer)
  end
end