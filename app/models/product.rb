class Product < ApplicationRecord
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks

  validates :title, :body, :price, presence: { message: 'must be present' }
  has_one_attached :file
  after_save :log_save
  after_commit :notify_user

  private

  def log_save
    # binding.pry
    puts "Order #{id} has been saved."
    # This will execute immediately after save, even if the transaction hasn't been committed yet.
  end

  def notify_user
    puts "Order #{id} has been committed."
    # This will execute only after the transaction has been committed.
    # You might send an email to the user here.
  end

  # settings index: { number_of_shards: 1 } do
  #   mappings dynamic: 'false' do
  #     indexes :title, type: 'text'
  #     indexes :price, type: 'float'
  #   end
  # end

  # def self.search(query)
  #   __elasticsearch__.search(
  #     query: {
  #       bool: {
  #         should: [
  #           { wildcard: { title: "*#{query.downcase}*" } },
  #           { multi_match: { query: query, fields: %w[title price] } }
  #         ]
  #       }
  #     }
  #   )
  # end
end
