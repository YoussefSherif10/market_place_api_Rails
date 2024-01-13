class Product < ApplicationRecord
  validates :title, :user_id, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  belongs_to :user
end

# to make a relation between product and user
# first make the belongs_to user
# second make the has_many products and set the dependent to destroy to make the cascading behavior
# here you have foriegn key paret_id and points to the id of the parent
