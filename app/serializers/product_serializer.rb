class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :body, :price, :file_url

  def file_url
    rails_blob_url(object.file, host: ActionController::Base.default_url_options[:host]) if object.file.attached?
  end
end
