Rails.application.routes.draw do
    devise_for :users

    root 'fresh#index'
    post '/' => 'fresh#index'
    post '/search'  => 'fresh#search'
    get '/news/:news_category'  => 'fresh#news'
    get '/categories' => 'fresh#categories' 
    get '/top_news' => 'fresh#top_news'
    post '/like' => 'fresh#like'
    get '/edit' => 'fresh#edit'
    post '/save_edit' => 'fresh#save_edit'
end
