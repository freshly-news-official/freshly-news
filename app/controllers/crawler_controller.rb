require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'set'

class CrawlerController < ActionController::Base
  #get categories
  categories = Category.all.each

  #iterate every category
  categories.each do |e|
    #get the page of the category
    page = Nokogiri::HTML(open(e.url))

    #get the tag name and class name of the current site
    site = Website.all.select{|element| element.id == e.id_site}

    #build the tag to search by
    tag = site[0].tag_name + '.' + site[0].tag_class

    #search the page
    page.css(tag).to_set.to_a.each{|element| puts element.attribute("href")}
  end

end
