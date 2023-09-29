class Public::GroupUsersController < ApplicationController
  before_action :authenticate_customer!

  def create
    group_user = current_customer.group_users.new(group_id: params[:group_id])
    group_user.save
    redirect_to request.referer
  end

  def destroy
    group_user = current_customer.group_users.find_by(group_id: params[:group_id])
    group_user.destroy
    redirect_to request.referer
  end
end
