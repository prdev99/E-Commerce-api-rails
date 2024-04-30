class SearchController < ApplicationController
  def search
    query = params[:query].presence
    search_type = params[:type]

    @products = if query.blank?
                  Product.all
                else

                  case search_type
                  when 'first_letter'
                    Product.search_by_first_letter(query)
                  when 'full_text'
                    Product.search_full_text(query)
                  else
                    Product.search(query)
                  end
                end

    data = if @products.respond_to?(:records)
             @products.records
           else
             @products.results
           end

    render json: data, each_serializer: ProductSerializer
  end
end
