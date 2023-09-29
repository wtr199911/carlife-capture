class Public::GroupsController < ApplicationController
  before_action :authorize_access
  before_action :ensure_correct_customer, only: [:edit, :update]

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
      @group.group_users.create(customer: current_customer)
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

  def destroy
    @group = Group.find(params[:id])

    if current_customer && @group.owner_id == current_customer.id && @group.customers.empty?
      @group.destroy
      flash[:alert] = "グループを削除しました。"
      redirect_to groups_path
    else
      flash[:alert] = "グループメンバーがいる為、グループを削除できません。"
      redirect_to groups_path
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :avatar)
  end

  def authorize_access
    # 管理者か会員のいずれかであればアクセスを許可
    unless admin_signed_in? || customer_signed_in?
      redirect_to root_path, alert: "ゲストログイン・新規登録・ログインをして下さい。"
    end
  end

  def ensure_correct_customer
    @group = Group.find(params[:id])
    unless admin_signed_in? || @group.owner_id == current_customer.id
      redirect_to groups_path, alert: "あなたはホストではない為、グループ編集できません。"
    end
  end

end
