require 'json'


class FreshController < ActionController::Base

  MAX_NEWS = 12
  MAX_NEWS_PER_CATEGORY = 3

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
    showed_news = 0;
    
    @news = []
    if news_category != "random"  and news_category != "all" then


      categories = Category.where({:nume => news_category})
      categories.each do |category|
        
        n = News.where({:category_id => category[:id]})

        if n != [] and n != nil then
                     n.each do |temp|
            news_item = {
                         :title => temp[:title], :description => temp[:description],
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

    elsif news_category == "random" 
      showed_news = 0

      if (current_user != nil)
        preferences = User.find_by(:id => current_user[:id])[:preferences]
        preferred_categories = preferences.split(',')
      end

      # modify here after growing database
      News.all.order(:date, :views, :votes).each do |item|
        category = Category.find_by({:id => item[:category_id]})
        if category != [] and category != nil then
          showed_news += 1
          @news.push({'title' => item.title, 'url' => item.url, 
                      'description' => item.description, 
                      'news_category' => category[:nume]
                   })
        end

        if (showed_news == MAX_NEWS)
          render json: @news
          return
        end
      end
    elsif news_category == "all"
    
      @news = []
      News.all().order(:views, :votes).each do |item|
        category = Category.find_by({:id => item[:category_id]})
        if category != [] and category != nil then
          @news.push({'title' => item.title, 'url' => item.url, 
                      'description' => item.description, 
                      'news_category' => category[:nume]
                   })
        end
      end

      render json: @news
      return
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
    @categories += ["random"]
    render json: @categories
  end
end
