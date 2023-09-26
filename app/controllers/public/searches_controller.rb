class Public::SearchesController < ApplicationController
  before_action :authorize_access

  def search
    @model = params[:model]
    @content = params[:content]
    @method = ""
    @post_page = Post.order("created_at DESC").page(params[:page]).per(6)
    @customer_page = Customer.page(params[:page])

   # 選択したモデルに応じて検索を実行
    if @model == "customer"
      @records = Customer.search_for(@content, @method)
    elsif @model == "post"
      @records = Post.search_for(@content, @method)
    elsif @model == "prefecture"
      @records = Prefecture.search_for(@content, @method)
    end
  end

  private

  def authorize_access
    # 管理者か会員かゲストユーザーのいずれかであればアクセスを許可
    unless admin_signed_in? || customer_signed_in? || guest_customer?
      redirect_to root_path
    end
  end

end
