class Public::SearchesController < ApplicationController

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

   # 選択したモデルに応じて検索を実行
    if @model == "customer"
      @records = Customer.search_for(@content, @method)
    elsif @model == "post"
      @records = Post.search_for(@content, @method)
    elsif @model == "prefecture"
      @records = Prefecture.search_for(@content, @method)
    end
  end

end
