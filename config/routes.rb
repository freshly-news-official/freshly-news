Rails.application.routes.draw do
    root 'fresh#index'
    post '/search'  => 'fresh#search'
    get '/news'    => 'fresh#news'
    get '/top_news' => 'fresh#top_news'
end
