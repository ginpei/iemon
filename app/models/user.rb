class User < ActiveRecord::Base
  class UnAuthorized < Exception ; end
  class NotAdminister < Exception ; end

  attr_accessible :gender, :age, :job

  private

  def self.create_with_omniauth(auth)
    user = User.new
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    
    unless auth["info"].blank?
      user.name = auth["info"]["name"]
      user.screen_name = auth["info"]["nickname"]
      user.image = auth["info"]["image"]
    end

    if DEFAULT_PROVIDER == "developer"
      user.screen_name = user.name
    end

    user.save
    user
  end
end
