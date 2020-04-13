class Customer < ApplicationRecord
	validates :name, :cpf, :email, presence: true  
end
