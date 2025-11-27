class SubscribersController < ApplicationController
  before_action :set_product, only: [ :create, :destroy ]
  allow_unauthenticated_access

  def create
    @product.subscribers.where(subscriber_params).first_or_create
    redirect_to @product, notice: "You are now subscribed."
  end

  def destroy
    subscriber = Subscriber.find_by(unsubscribe: params[:token])
    if subscriber
      subscriber.destroy
      redirect_to subscriber.product, notice: "You have unsubscribed."
    else
      redirect_to @product, alert: "Subscriber not found."
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
