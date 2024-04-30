class SearchController < ApplicationController

  def search
    query = params[:query].presence || '*'
    @products = Product.search(query)
    data = if @products.respond_to?(:records)
             @products.records
           else
             @products.results
           end

    render json: data, each_serializer: ProductSerializer
  end
end
