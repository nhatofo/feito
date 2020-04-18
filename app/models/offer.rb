class Offer < ApplicationRecord
  belongs_to :request
  belongs_to :user

  enum status: [:pendente, :aceite, :rejeitada]
  validates :amount, :days, numericality: { only_integer: true, message: "Tem que ser numerico" }
end
