module Api
  class ArticlesController < ApplicationController
    load_and_authorize_resource

    def index
      render json: { articles: @articles }
    end

    def show
      render json: { article: @article }
    end

    def create
      @article.user = current_user
      if @article.save
        render json: { article: @article }, status: 201
      else
        render json: { errors: @article.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      @article.destroy
      render json: { article: @article }, status: :ok
    end

    def update
      if @article.update_attributes(article_params)
        render json: { article: @article }
      else
        render json: { errors: @article.errors }, status: :unprocessable_entity
      end
    end

    def current_ability
      @current_ability ||= ::ArticleAbility.new(current_user)
    end

    private

    def article_params
      params.require(:article).permit(:title, :body)
    end
  end
end
