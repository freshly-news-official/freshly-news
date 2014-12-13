Rails.application.routes.draw do
  devise_for :users
    root 'fresh#index'

    post '/search'  => 'fresh#search'
    get '/news'    => 'fresh#news'
    get '/top_news' => 'fresh#top_news'
end
