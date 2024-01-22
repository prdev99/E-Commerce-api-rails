class Product < ApplicationRecord
  validates :title, :body, :price, presence: true
  has_one_attached :file
end
