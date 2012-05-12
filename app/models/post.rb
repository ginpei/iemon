class Post < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user
  attr_accessible :body
end
