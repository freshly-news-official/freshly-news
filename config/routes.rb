Rails.application.routes.draw do
    devise_for :users

    root'fresh#index'

    post '/search'  => 'fresh#search'
    get '/news/:news_category'  => 'fresh#news'
    get '/categories' => 'fresh#categories' 
    get '/top_news' => 'fresh#top_news'
end
