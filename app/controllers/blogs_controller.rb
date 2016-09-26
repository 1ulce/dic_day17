class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :confirm]
  
  def index
    # default画面(編集済み一覧)
    @blogs = Blog.where(status: 3)
  end
  def index_1
    # 下書き一覧画面
    @blogs = Blog.where(status: 1)
  end

  def index_2
    # 公開画面
    @blogs = Blog.where(status: 2)
  end

  def index_3
    # 編集済み画面
    redirect_to action: 'index'
  end

  def index_4
    # 削除済み一覧画面
    @blogs = Blog.where(status: 4)
  end

  def show
    if @blog.status == 4
      redirect_to action: 'index', notice: "このブログは削除済みなため、表示できません"
    end
  end

  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new(status: 0)
    end
  end

  def create
    @blog = Blog.new(blogs_params)
    if @blog.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      @blog.status = @blog.status + 1
      @blog.save
      redirect_to index_1_blogs_path, notice: "ブログを作成しました！"
    else
      # 入力フォームを再描画します。
      render action: 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @blog.update(blogs_params)
      if @blog.status == 1
        @blog.update(status: 2)
        redirect_to index_2_blogs_path, notice: "ブログを公開しました！"
      elsif @blog.status == 2
        @blog.update(status: 3)
        redirect_to blogs_path, notice: "ブログを編集しました！"
      else
        redirect_to blogs_path, notice: "ブログを編集しました！"
      end
    else
      # 入力フォームを再描画します。
      render action: 'edit'
    end
  end
  
  def destroy
    @blog.update(status: 4)
    redirect_to index_4_blogs_path, notice: "ブログを削除しました！"
  end

  def confirm
  end
  
  private
    def blogs_params
      params.require(:blog).permit(:title, :status)
    end
    def set_blog
      @blog = Blog.find(params[:id])
    end
end

