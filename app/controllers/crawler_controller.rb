require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'set'
require 'net/http'
require 'uri'

def working_url?(url, max_redirects=6)
  response = nil
  seen = Set.new
  loop do
    url = URI.parse(url)
    break if seen.include? url.to_s
    break if seen.size > max_redirects
    seen.add(url.to_s)
    response = Net::HTTP.new(url.host, url.port).request_head(url.path)
    if response.kind_of?(Net::HTTPRedirection)
      url = response['location']
    else
      break
    end
  end
  response.kind_of?(Net::HTTPSuccess) && url.to_s
end

class CrawlerController < ActionController::Base
  #get categories
  categories = Category.all.each

  #iterate every category
  categories.each do |e|
    #get  http response 
    response = Net::HTTP.get_response(URI.parse(e.url))

    #verify if the response is positive
    if response.code.to_i > 199 and response.code.to_i < 400
      #load page
      page = Nokogiri::HTML(open(e.url))
      puts Net::HTTP.get_response(URI.parse(e.url)).code

      #get the tag name and class name of the current site
      site = Website.all.select{|element| element.id == e.site_id}

      #build the tag to search by
      tag = site[0].tag_name + '.' + site[0].tag_class

      #search the page
      page.css(tag).to_set.to_a.each do |element| 
        #puts element.attribute("href").to_s

        #if the news is not in the database, add it
        if not News.exists?(:url => element.attribute("href").to_s)
          new_title = element.attribute("title").to_s
          new_description = "..."
          new_category = e.id.to_i
          new_url = element.attribute("href").to_s

          #get new response
          res = Net::HTTP.get_response(URI.parse(new_url))

          #verify if it's a valid response
          #if res.code.to_i > 199 and res.code.to_i < 400
          if working_url?(new_url)
            new_content = open(new_url, &:read)

            News.create(:title => new_title, :description => "...", :category_id => new_category, :views => 0, :votes => 0, :url => new_url, :content => new_content)
          end
        end
      end
    end
  end
end
