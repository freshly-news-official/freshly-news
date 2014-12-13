class FreshController < ActionController::Base

	def index
	end

  def search

    search_term = params[:search_term]

    @results = News.find_by({:title => search_term })


    render json: @results 
  end 
end
