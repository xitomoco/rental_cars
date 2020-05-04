require 'rails_helper'

describe "Subsidiary" do

  context '#name' do
    it 'cannot be blank' do
      subsidiary = Subsidiary.new(name: '')

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('Você deve informar todos os dados da filial')
    end

    it 'must be unique' do
      Subsidiary.create!(name: 'Nome', cnpj: '50.032.471/0001-50', address: 'Rua das flores')
      subsidiary = Subsidiary.new(name: 'Nome')

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('Nome já esta em uso')
    end
  end

  context '#cnpj' do
    it 'cannot be blank' do
      subsidiary = Subsidiary.new(cnpj: '')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('Você deve informar todos os dados da filial')
    end

    it 'must be unique' do
      Subsidiary.create!(name: 'Nome', cnpj: '50.032.471/0001-50', address: 'Rua das flores')
      subsidiary = Subsidiary.new(cnpj: '50.032.471/0001-50')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('CNPJ já esta em uso')
    end

    it 'must be valid format ponctuated' do
      subsidiary = Subsidiary.new(cnpj: '50.032.471/7001-00')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('CNPJ não é valido')
    end

    it 'must be valid format unponctuated' do
      subsidiary = Subsidiary.new(cnpj: '50032471700100')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('CNPJ não é valido')
    end
  end
end