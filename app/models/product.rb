class Product < ApplicationRecord
  validates :title, :body, presence: true
end
