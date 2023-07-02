class ArticlesController < ApplicationController
  def index
    articles = Article.all.includes(:user).order(created_at: :desc)
    render json: articles, each_serializer: ArticleListSerializer
  end
  

  def show
    # Initialize session[:page_views] if it doesn't exist
    session[:page_views] ||= 0

    # Increment the value of session[:page_views] by 1
    session[:page_views] += 1

    if session[:page_views] <= 3
      # User has viewed three or fewer pages
      article = Article.find(params[:id])
      render json: article
    else
      # User has viewed more than three pages
      render json: { error: "Maximum pageview limit reached" }, status: :unauthorized
    end
  end
end
