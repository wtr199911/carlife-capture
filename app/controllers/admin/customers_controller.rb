class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.order("created_at DESC").page(params[:page]).per(4)
    @count_posts = @customer.posts.count
    @customers = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id), notice: "保存に成功しました！"
    else
      redirect_to information_path, alert: "編集に失敗しました"
    end
  end

  private

  def customer_params
    params.require(:customer).permit( :name, :profile_image, :profile_text, :is_valid, :avatar )
  end

end
