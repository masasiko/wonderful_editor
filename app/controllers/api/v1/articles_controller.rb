class Api::V1::ArticlesController < Api::V1::BaseApiController
   before_action :authenticate_api_v1_user!, only: [:create, :update, :destroy] # ログインユーザーでなければ実行されない

  def index
    binding.pry
    Article.all
    binding.pry
    article = Article.published.order("updated_at DESC")
    binding.pry
    render json: article, each_serializer: Api::V1::ArticlePreviewSerializer
  end

  def show
    article = Article.find(params[:id])
    render json: article, serializer: Api::V1::ArticleSerializer
  end

  def create
    article = Article.new(article_params)
    article.user_id = current_api_v1_user.id# ログインユーザーのuser_idになる
    article.save!
    render json: article, serializer: Api::V1::ArticleSerializer
  end

  def update
    article = Article.find(params[:id])
    article.update!(article_params)
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy!
    render json: article, serializer: Api::V1::ArticleSerializer
  end

  private

    # def set_article
    #   article = current_user.articles.find(params[:id])
    # end

    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
