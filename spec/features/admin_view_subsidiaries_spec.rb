require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create(name: 'Nome da filial', cnpj: 'CNPJ da filial', 
                      address: 'Endereço da filial')

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nome da filial')
    expect(page).not_to have_content('CNPJ da filial')
    expect(page).not_to have_content('Endereço da filial')
  end

  scenario 'and view datails' do
    Subsidiary.create(name: 'Nome da filial', cnpj: 'CNPJ da filial', 
                      address: 'Endereço da filial')

    visit root_path
    click_on 'Filiais'
    click_on 'Nome da filial'

    expect(page).to have_content('Nome da filial')
    expect(page).to have_content('CNPJ da filial')
    expect(page).to have_content('Endereço da filial')
    expect(page).not_to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and no subsidiáries are created' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and from index return to root' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and from show return to index' do
    Subsidiary.create(name: 'Nome da filial', cnpj: 'CNPJ da filial', 
                      address: 'Endereço da filial')

    visit root_path
    click_on 'Filiais'
    click_on 'Nome da filial'

    expect(page).to have_link('Voltar', href: subsidiaries_path)
  end
end