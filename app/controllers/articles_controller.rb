class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :check_user, only: [:edit, :update, :destroy]
def myrecipes
  @articles = Article.where(user: current_user)
end

  def index
      if params[:search]
        @articles = Article.search(params[:search]).order("created_at DESC")
      else
        @articles = Article.all.order('created_at DESC')
      end
  end
  def new_arrivals
    @articles = Article.all.order('created_at DESC')
  end
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end
def edit
  @article = Article.find(params[:id])
end
def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
  def set_article
      @article = Article.find(params[:id])
  end

  def check_user
    if current_user != @article.user
      redirect_to root_url, alert: "Sorry this isn't your listing"
    end
  end

  def article_params
    params.require(:article).permit(:title, :text, :image)
  end

end
