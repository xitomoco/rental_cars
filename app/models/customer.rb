class Customer < ApplicationRecord
  validates :name, :cpf, :email, presence: 
  { message: "Você deve informar todos os dados do cliente" }
end
