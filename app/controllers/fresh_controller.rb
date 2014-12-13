require 'json'


class FreshController < ActionController::Base

	def index
	end

  def search
    raw_input = JSON.parse(request.body.read())

    search_term = raw_input["search_term"].gsub(/[^a-zA-Z0-9 ]/, "")
    @results = []

    News.where('title like ?', '%' + search_term + '%').each do |news|
      @results.push({'title' => news.title, 
                    'url' => news.url , 
                    'description' => news.description})
    end

    render json: @results
  end 


  def news
    raw_input = JSON.parse(request.body.read())

    news_category = raw_input["news_category"].gsub(/[^a-zA-Z0-9 ]/, "")
    from = raw_input["from"].to_i
    to = raw_input["to"].to_i

    @news = []
    categories_ids = Category.where({:nume => news_category})
    categories_ids.each do |id|
      n = News.where({:id_category => id})
      @news += n if n != []
    end

    @news.sort_by { |n| n[:ews]} 
 

    render json: @news[from..to]
  end 

end
