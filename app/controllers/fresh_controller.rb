require 'json'


class FreshController < ActionController::Base

	def index
	end

  def search
    raw_input = JSON.parse(request.body.read())

    search_term = raw_input["search_term"].gsub(/[^a-zA-Z0-9 ]/, "")
    @results = []

    News.where('title like ?', '%' + search_term + '%').each do |news|
      @results.push({'title' => news.title, 'url' => news.url })
    end

    render json: @results
  end 

  def news
    raw_input = JSON.parse(request.body.read())

    news_category = raw_input["news_category"].gsub(/[^a-zA-Z0-9 ]/, "")
    limit = raw_input["news_category"].gsub(/[^a-zA-Z0-9 ]/, "").to
    p news_category
    p limit

    @results = []

    News.where('title like ?', '%' + search_term + '%').each do |news|
      @results.push({'title' => news.title, 'url' => news.url })
    end

    render json: @results
  end 

end
