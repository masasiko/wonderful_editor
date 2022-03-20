class Api::V1::ArticlesController < ApplicationController
  def index
    #article = Article.all
    @article =Article.order("updated_at DESC")
    render json: @article, each_serializer: Api::V1::ArticlePreviewSerializer
  end

def show
  binding.pry
@article = Article.find(params[:id])


end

end
