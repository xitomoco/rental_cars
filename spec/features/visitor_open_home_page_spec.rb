require 'rails_helper'

feature 'Visitor open home page' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user
    
    visit root_path

    expect(page).to have_content('Rental Cars')
    expect(page).to have_content('Bem vindo ao sistema de gestão de locação')
  end
end