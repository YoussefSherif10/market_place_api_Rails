class Order < ApplicationRecord
  belongs_to :user
  validates :total, presence: true
  validates :total, numericality: { greater_than: 0 }
  has_many :placements, dependent: :destroy
  has_many :products, through: :placements
end
