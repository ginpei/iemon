class Post < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user
  attr_accessible :body
  validates :theme_id, :presence => true, :uniqueness => true
end
