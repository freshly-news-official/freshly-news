class Category < ActiveRecord::Base
  belongs_to :website
  belongs_to :category_name
  has_many :news
end
