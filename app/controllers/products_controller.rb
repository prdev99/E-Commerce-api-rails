# app/controllers/products_controller.rb

class ProductsController < ApplicationController
  before_action :set_product, only: %i[update destroy show]

  def index
    products = Product.all
    render json: products, each_serializer: ProductSerializer
  end

  def create
    product = Product.create(product_params)
    render json: product, serializer: ProductSerializer
  end

  def show
    return unless @product.present?

    render json: @product
  end

  def update
    return unless @product.present?
    return render json: { message: 'Product Error' } unless @product.update(product_params)

    render json: @product
  end

  def destroy
    return unless @product.destroy

    render json: { meta: [{ message: 'Product Deleted Successfully' }] }, status: :ok
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :body, :price, :file)
  end
end
