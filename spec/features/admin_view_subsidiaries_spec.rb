require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create(name: 'Nome da filial', cnpj: '99.757.632/8324-85', 
                      address: 'Endereço da filial')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nome da filial')
    expect(page).not_to have_content('99.757.632/8324-85')
    expect(page).not_to have_content('Endereço da filial')
  end

  scenario 'and view datails' do
    Subsidiary.create(name: 'Nome da filial', cnpj: '99.757.632/8324-85', 
                      address: 'Endereço da filial')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'Nome da filial'

    expect(page).to have_content('Nome da filial')
    expect(page).to have_content('99.757.632/8324-85')
    expect(page).to have_content('Endereço da filial')
    expect(page).not_to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and no subsidiáries are created' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and from index return to root' do
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and from show return to index' do
    Subsidiary.create(name: 'Nome da filial', cnpj: '99.757.632/8324-85', 
                      address: 'Endereço da filial')
    user = User.create!(email: 'teste@teste.com', password: '123456789')
    login_as user, scope: :user

    visit root_path
    click_on 'Filiais'
    click_on 'Nome da filial'

    expect(page).to have_link('Voltar', href: subsidiaries_path)
  end
end