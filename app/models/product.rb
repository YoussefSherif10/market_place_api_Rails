class Product < ApplicationRecord
  validates :title, :user_id, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  belongs_to :user
end
