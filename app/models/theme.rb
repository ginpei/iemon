# encoding: utf-8

class Theme < ActiveRecord::Base
  attr_accessible :body, :target_date

  has_many :posts

  validates :target_date, :presence => true, :uniqueness => true

  default_scope :order => 'target_date DESC'
  paginates_per 20

  def self.today
    Theme.where(:target_date => Date.today).first # TODO: 21:00-翌9:00までとすること
  end
end
