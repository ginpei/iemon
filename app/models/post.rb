class Post < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user
  attr_accessible :body
  validates_presence_of :theme_id
  validates_uniqueness_of :theme_id, :scope => :user_id

  default_scope :order => 'created_at DESC'
  paginates_per 20

end
