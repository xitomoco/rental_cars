class Customer < ApplicationRecord
  validates :name, :cpf, :email, presence: 
  { message: "Você deve informar todos os dados do cliente" }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :cpf_must_be_valid

  private

  def cpf_must_be_valid
    return if CPF.valid?(cpf)
    errors.add(:cpf, 'CPF invalido')
  end
end
