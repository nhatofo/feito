class Request < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :attachment_file
  has_many :offers, dependent: :delete_all
  has_many :orders

  validates :title, presence: { message: "Não pode ser nulo! " }
  validates :description, presence: { message: "Não pode ser nulo" }
  validates :delivery, numericality: { only_integer: true, message: "Tem que ser numerico" }
end
