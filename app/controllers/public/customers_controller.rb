class Public::CustomersController < ApplicationController

  def mypage
    @customer = current_customer
  end

end
