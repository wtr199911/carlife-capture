class Public::CustomersController < ApplicationController

  def mypage
    @customer = current_customer
    @posts = @customer.posts.order("created_at DESC").page(params[:page]).per(5)
  end

  def edit
    @customer = current_customer
  end

  def update
   if current_customer.update(customer_params)
     redirect_to mypage_path
   else
     redirect_to infomation_path
   end
  end

  def confirm_withdraw
  end

  def withdraw
    current_customer.update(is_valid: false)
    reset_session
    flash[:alert] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit( :name, :profile_image, :profile_text)
  end


end
