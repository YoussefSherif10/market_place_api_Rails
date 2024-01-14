class Api::V1::ProductsController < ApplicationController
    before_action :check_login, only: [:create]
    before_action :check_owner, only: %i[update destroy]
    def show
        @product = Product.find(params[:id])
        render json: ProductSerializer.new(@product, { include: [:user]}).serializable_hash, status: :ok
    end

    def index
        products = Product.page(params[:page]).per(params[:per_page]).search(params)
        options = links('api_v1_products_path', products)
        render json: ProductSerializer.new(products, options).serializable_hash, status: :ok
    end

    def create
        product = current_user.products.build(product_params)
        if product.save
            render json: ProductSerializer.new(product).serializable_hash, status: :created
        else
            render json: product.errors, status: :unprocessable_entity
        end
    end

    def update
        product = products.find(params[:id])
        if product.update(product_params)
            render json: ProductSerializer.new(@product).serializable_hash, status: :ok
        else
            render json: @product.errors, status: :unprocessable_entity
        end
    end

    def destroy
        product = products.find(params[:id])
        product.destroy
        head(:no_content)
    end

    private 

    def product_params
        params.require(:product).permit(:title, :price, :published)
    end

    def check_owner
        head(:forbidden) unless @product.user_id == current_user&.id
    end
end
