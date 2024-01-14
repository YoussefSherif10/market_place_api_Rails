class Order < ApplicationRecord
  belongs_to :user
  validates: total, presence: true
  validates: total, numericality: { greater_than: 0 }
end
