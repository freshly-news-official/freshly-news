Rails.application.routes.draw do
    root 'fresh#index'
    post '/search'  => 'fresh#search'
    post '/news'    => 'fresh#news'
end
