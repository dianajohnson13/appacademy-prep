class ApplicationController < ActionController::Base
	before_filter :populate_months
	before_filter :populate_top_articles

	protected

	def populate_months
		articles = Article.all
		@active_months = []
		articles.each do |article| 
			curr_month = article.month
			p curr_month
			@active_months << curr_month unless @active_months.include?(curr_month)
		end
	end

	def populate_top_articles
		@top_articles = Article.all.order(view_count: :desc).limit(3)
	end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
