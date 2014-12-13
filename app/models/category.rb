class Category < ActiveRecord::Base
  belongs_to :website
  has_many :news
end
