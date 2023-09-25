class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id), notice: "保存に成功しました！"
    else
      render template: "public/edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit( :name, :profile_image, :profile_text, :is_valid, :avatar )
  end

end
