class Public::GroupsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update]
  before_action :ensure_guest_customer

  def index
    @groups = Group.all.page(params[:page]).per(10)
    @group_page = @groups
  end

  def show
    @group = Group.find(params[:id])
    @group_users = @group.customers
    @group_page = @group.customers.page(params[:page]).per(10)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_customer.id
    if @group.save
      flash[:notice] = "グループを作成しました。"
      redirect_to groups_path
    else
      render :new, alert: "作成に失敗しました"
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "グループを更新しました。"
      redirect_to groups_path
    else
      render :edit, alert: "更新に失敗しました"
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :avatar)
  end

  def ensure_correct_customer
    @group = Group.find(params[:id])
    unless @group.owner_id == current_customer.id
      redirect_to groups_path, alert: "あなたはホストではない為、グループ編集できません。"
    end
  end

  def ensure_guest_customer
   if current_customer.guest_customer?
     redirect_to mypage_path(current_customer), alert: "ゲストユーザーはグループ加入できません。新規作成・ログインして下さい。"
   end
  end

end
