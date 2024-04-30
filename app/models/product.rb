class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :title, :body, :price, presence: true
  has_one_attached :file

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, type: 'text'
      indexes :price, type: 'float'
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      query: {
        bool: {
          should: [
            { wildcard: { title: "*#{query.downcase}*" } },
            { multi_match: { query: query, fields: %w[title price] } }
          ]
        }
      }
    )
  end
end
