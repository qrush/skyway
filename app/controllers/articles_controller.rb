class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index
    if admin?
      @articles = Article.published
    else
      @articles = Article.undrafted.published
    end
  end

  def show
    if !admin? && @article.draft?
      redirect_to articles_path, flash: {error: "Not ready yet!"}
    end
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
  end

  def update
    if @article.update_attributes(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, flash: {success: "Deleted #{@article.title}."}
  end

  private

    def article_params
      params.require(:article).permit(:title, :body, :draft, :published_at, :facebook_image_url)
    end

    def set_article
      @article = Article.find(params[:id])
    end

end
