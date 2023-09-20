class Public::RelationshipsController < ApplicationController

  def create
    @customer = Customer.find(params[:customer_id])
    current_customer.follow(@customer)
  end

  def destroy
    @customer = Customer.find(params[:customer_id])
    current_customer.unfollow(@customer)
  end

  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings
    @page = Customer.page(params[:page])
  end

  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers
    @page = Customer.page(params[:page])
  end

end
