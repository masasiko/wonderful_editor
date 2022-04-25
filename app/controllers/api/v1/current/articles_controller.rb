class Api::V1::Current::ArticlesController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    Article.all
    article = current_api_v1_user.articles.published.order("updated_at DESC")
    binding.pry
    render json: article, each_serializer: Api::V1::ArticlePreviewSerializer
  end

  def show
    article = current_api_v1_user.articles.published.find(params[:id])
    render json: article, serializer: Api::V1::ArticleSerializer
  end









end
