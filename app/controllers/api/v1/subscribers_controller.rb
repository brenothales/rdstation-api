class Api::V1::SubscribersController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_subscriber, only: [:update, :destroy]
  before_action :set_product
  before_action :allow_only_owner, only: [:create, :update, :destroy]

  def update
    @subscriber.update(subscriber_params)
    render json: @subscriber
  end

  def create
    @subscriber = Product.create(subscriber_params.merge(product: @product))
    render json: @subscriber
  end

  def destroy
    @subscriber.destroy
    render json: {message: 'ok'}
  end

  private

    def set_subscriber
      @subscriber = Product.find(params[:id])
    end

    def set_product
      @product = (@subscriber)? @subscriber.product : Product.find(params[:product_id])
    end

    def allow_only_owner
      unless current_api_v1_user == @product.user
        render(json: {}, status: :forbidden) and return
      end
    end

    def subscriber_params
      params.require(:subscriber).permit(:manager_id, :payer_id, :product_id)
    end
end