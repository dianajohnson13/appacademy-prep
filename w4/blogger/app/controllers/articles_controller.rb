class ArticlesController < ApplicationController

	include ArticlesHelper

	before_filter :require_login, only: [:new, :create, :edit, :update, :destroy]
	
	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
		@article.increment_view_count
		@article.save

		@comment = Comment.new
		@comment.article_id = @article.id
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		@article.save

		flash.notice = "'#{@article.title}' has been created!"

		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		flash.notice = "'#{@article.title}' has been destroyed!"

		redirect_to articles_path
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		@article.update(article_params)

		flash.notice = "Article '#{@article.title}' Updated!"

		redirect_to article_path(@article)
	end


	def months
		@curr_month = params[:month]
		articles = Article.all
		@articles_in_month = []
		articles.each do |article| 
			@articles_in_month << article if article.month == @curr_month
		end
	end
end
