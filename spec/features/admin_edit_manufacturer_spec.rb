require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Fiat')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Honda')
  end

  scenario 'and name cannot be blank' do
    Manufacturer.create!(name: 'Fiat')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and name must be uniquen' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Honda')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Nome deve ser único')
  end
end
