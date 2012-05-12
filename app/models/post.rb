class Post < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user
  attr_accessible :body
  validates_presence_of :theme_id
  validates_uniqueness_of :theme_id, :scope => :user_id
  validates_length_of :body, :minimum => 1
  validates_length_of :body, :maximum => 140

  default_scope :order => 'created_at DESC'
  paginates_per 20

end
