require 'rails_helper'

RSpec.describe Customer, type: :model do
  context '#search' do
    it 'by name' do
      other_customer = Customer.create!(name: 'Outro Cliente', cpf: '525.376.945-54', email: 'teste@teste.com')
      customer = Customer.create!(name: 'Nome cliente', cpf: '637.421.553-26', email: 'teste@teste.com')
    
      result = Customer.search('Nome')
    
      expect(result).to include(customer)
      expect(result).not_to include(other_customer)
    end
    
    it 'and by parcial name' do
      other_customer = Customer.create!(name: 'José mendes', cpf: '525.376.945-54', email: 'teste@teste.com')
      customer = Customer.create!(name: 'Nome cliente', cpf: '637.421.553-26', email: 'teste@teste.com')
    
      result = Customer.search('cliente')
    
      expect(result).to include(customer)
      expect(result).not_to include(other_customer)
    end

    it 'and finds nothing' do
      other_customer = Customer.create!(name: 'José mendes', cpf: '525.376.945-54', email: 'teste@teste.com')
      customer = Customer.create!(name: 'Nome cliente', cpf: '637.421.553-26', email: 'teste@teste.com')
    
      result = Customer.search('das')
    
      expect(result).to be_blank
    end

    it 'and by cpf' do
      other_customer = Customer.create!(name: 'José mendes', cpf: '525.376.945-54', email: 'teste@teste.com')
      customer = Customer.create!(name: 'Nome cliente', cpf: '637.421.553-26', email: 'teste@teste.com')
    
      result = Customer.search('637.421.553-26')
    
      expect(result).to include(customer)
      expect(result).not_to include(other_customer)
    end
  end
end
