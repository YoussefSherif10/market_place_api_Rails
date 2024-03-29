class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[index show create]
  def index
    orders = current_user.orders.page(params[:page]).per(params[:per_page])
    options = links('api_v1_orders_path', orders)
    render json: OrderSerializer.new(orders, options).serializable_hash
  end

  def show
    order = current_user.orders.find(params[:id])

    if order
      render json: OrderSerializer.new(order, { include: [:products]}).serializable_hash
    else
      head(:not_found)
    end
  end

  def create
    order = current_user.orders.build(order_params)

    if order.save
      render json: OrderSerializer.new(order, { include: [:products]}).serializable_hash, status: :created
    else
      render json: order.errors, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(product_ids: [])
  end
end
