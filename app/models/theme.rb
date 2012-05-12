# encoding: utf-8

class Theme < ActiveRecord::Base
  attr_accessible :body, :target_date

  has_many :posts

  validates :target_date, :uniqueness => true

  default_scope :order => 'target_date DESC'
  paginates_per 20

  def self.today
    Theme.where(:target_date => Date.today).first # TODO: 21:00-翌9:00までとすること
  end

  scope :active, where(:status => 'active')

  # activateする
  # すでにactivateがある場合は、deactivateした上で新たにひとつactivateする
  def self.activate(date=Date.today)
    # dateのものがもう既に存在すれば、activateできない
    raise ArgumentError unless Theme.where(:target_date => date).size == 0
    Theme.deactivate
    update_target = Theme.where('status IS NULL').order('created_at').first # 一番古いものを抽出
    update_target.status = 'active'
    update_target.target_date = date
    update_target.save
  end

  def self.deactivate
    # activeなやつをdeactivateする
    @actives = Theme.active
    @actives.each do |ac|
      ac.status = 'deactive'
      ac.save
    end
  end
end
