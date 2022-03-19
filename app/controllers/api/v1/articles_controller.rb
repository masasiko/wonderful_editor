class Api::V1::ArticlesController < ApplicationController
  def index
     articles = Article.all(:title)
     binding.pry
     render json: articles
  end
end
