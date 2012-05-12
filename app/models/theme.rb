# encoding: utf-8

class Theme < ActiveRecord::Base
  attr_accessible :body, :target_date

  def self.today
    Theme.where(:target_date => Date.today).first # TODO: 21:00-翌9:00までとすること
  end
end
