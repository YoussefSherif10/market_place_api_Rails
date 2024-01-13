class Product < ApplicationRecord
  validates :title, :user_id, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  belongs_to :user
  # scope is for making a method, lambda is for anonymous function, query is for the argument of the lambda
  # lower makes the search case insensitive, LIKE is for pattern matching, % % means partial match
  # ? is a placeholder to avoid SQL injection
  scope :filter_by_title , lambda { |query| where("lower(title) LIKE ?", "%#{query.downcase}%") }
  scope :filter_by_price , lambda { |query| where("price >= ?", query) }
  scope :sort_by_creation , lambda { order(created_at: :desc) }
  scope :recent , lambda {order(updated_at: :desc)}
end

# to make a relation between product and user
# first make the belongs_to user
# second make the has_many products and set the dependent to destroy to make the cascading behavior
# here you have foriegn key paret_id and points to the id of the parent
