class UserData < ActiveRecord::Base
  attr_accessible :data, :user_id
  serialize :data

  def player
    data[:player]
  end

  def reset
    self.data = {
      :player => Player.new,
      :characters => Array.new(3) { Character.new },
    }
  end
end

require 'ostruct'
class Character < OpenStruct
  def initialize
    super
    setup
  end

  def setup
    self.hp = 3
    self
  end
end

class Player < Character
end
