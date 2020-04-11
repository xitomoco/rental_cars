require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfuly' do
    visit root_path
    click_on 'Cadastrar filial'

    fill_in 'Nome', with: 'Nome da filial'
    fill_in 'CNPJ', with: 'CNPJ da filial'
    fill_in 'Endereço', with: 'Endereço da filial'
    click_on 'Enviar'

    expect(page).to have_content('Nome da filial')
    expect(page).to have_content('CNPJ da filial')
    expect(page).to have_content('Endereço da filial')
  end

  scenario 'and check all create fields are fill' do
    visit root_path
    click_on 'Cadastrar filial'

    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da filial')
  end

  scenario 'and update subsidiary' do
    Subsidiary.create(name: 'Nome da filial 1', cnpj: 'CNPJ da filial 1', 
                      address: 'Endereço da filial 1')

    visit root_path
    click_on 'Filiais'
    click_on 'Nome da filial'
    click_on 'Editar'

    fill_in 'Nome', with: 'Nome da filial 2'
    fill_in 'CNPJ', with: 'CNPJ da filial 2'
    fill_in 'Endereço', with: 'Endereço da filial 2'
    click_on 'Enviar'

    expect(page).to have_content('Nome da filial 2')
    expect(page).to have_content('CNPJ da filial 2')
    expect(page).to have_content('Endereço da filial 2')
  end

  scenario 'and check all update fields are fill' do
    Subsidiary.create(name: 'Nome da filial 1', cnpj: 'CNPJ da filial 1', 
                      address: 'Endereço da filial 1')

    visit root_path
    click_on 'Filiais'
    click_on 'Nome da filial'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da filial')
  end
end