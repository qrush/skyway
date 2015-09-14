class ArticlesController < ApplicationController
  before_filter :require_admin, except: [:index, :show]

  def index
    if admin?
      @articles = Article.published
    else
      @articles = Article.undrafted.published
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update_attributes(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, flash: {success: "Deleted #{@article.title}."}
  end

  private

    def article_params
      params.require(:article).permit(:title, :body, :draft, :published_at)
    end
end
