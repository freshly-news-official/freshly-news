require 'json'


class FreshController < ActionController::Base

  MAX_NEWS = 12

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

    render json: @results[0...MAX_NEWS]
  end 


  def news

    news_category = params[:news_category].gsub(/[^a-zA-Z0-9 ]/, "")

    @news = []
    if news_category != "random" then

      showed_news = 0;

      categories = Category.where({:nume => news_category})
      categories.each do |category|
        
        n = News.where({:category_id => category[:id]})

        if n != [] then

          n.each do |temp|
            news_item = {:title => temp[:title], :description => temp[:description],
                         :views => temp[:views], :votes => temp[:votes],
                         :news_category => category[:nume]
                        }
            showed_news += 1

            @news.push(news_item)
            if (showed_news == MAX_NEWS)
              render json: @news
              return
            end

          end          
        end
      end
    
      @news.sort_by { |n| n[:views]} 

    else
      showed_news = 0

      # modify here after growing database
      News.all.order(:views, :votes).each do |item|
        showed_news += 1
        @news.push({'title' => item.title, 'url' => item.url, 
                    'description' => item.description, 
                    'news_category' => Category.find_by({:id => item[:category_id]})[:nume]
                  })

        if (showed_news == MAX_NEWS)
          render json: @news
          return
        end
      end

    end

    render json: @news
  end


  def top_news
    @results = []

    News.all.order(:views, :votes).limit(10).each do |item|
      @results.push({'title' => item.title, 'url' => item.url, 
                    'description' => item.description})
    end

    render json: @results
  end


  def categories
    @categories = Category.uniq.pluck(:nume)

    render json: @categories
  end
end
