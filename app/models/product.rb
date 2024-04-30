class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :title, :body, :price, presence: true
  has_one_attached :file

  def self.search_by_first_letter(letter)
    __elasticsearch__.search(
      {
        query: {
          prefix: {
            title: letter
          }
        }
      }
    )
  end

  def self.search_full_text(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query:,
            fields: %w[title price]
          }
        }
      }
    )
  end
end
