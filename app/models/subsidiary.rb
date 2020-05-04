class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: { message: "Você deve informar todos os dados da filial" }
  validates :name, uniqueness: { message: "Nome já esta em uso"}
  validates :cnpj, uniqueness: { message: "CNPJ já esta em uso"}
  validate :cnpj_must_be_valid

  private

  def cnpj_must_be_valid
    return if CNPJ.valid?(cnpj)
    errors.add(:cnpj, 'CNPJ não é valido')
  end
end
