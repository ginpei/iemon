
Twitter.configure do |config|
  config.consumer_key = ENV['TW_CONSUM_KEY']
  config.consumer_secret = ENV['TW_CONSUM_SECRET']
  config.oauth_token = ENV['TW_ACS_TOKEN']
  config.oauth_token_secret = ENV['TW_ACS_SECRET']
end

