ENV['TWITTER_KEY'] = "VGPObUV3PWCC5RYU2lQmWw"
ENV['TWITTER_SECRET'] = "MqOE6OlZaUDU2erUPHZtBAgpo8SN83S6Ne1BL5fFqU"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end
