# encoding: utf-8

task :cron => :environment do
  Twitter.configure do |config|
    config.consumer_key = ENV['TW_CONSUM_KEY']
    config.consumer_secret = ENV['TW_CONSUM_SECRET']
    config.oauth_token = ENV['TW_ACS_TOKEN']
    config.oauth_token_secret = ENV['TW_ACS_SECRET']
  end

  begin
    theme = Theme.activate
  rescue => e
  end
  unless theme.nil?
    begin
      url = "http://oyasumi-tanuki.net/themes/#{theme.id}"

      body = "【本日の皮算用】#{theme.body}"
      # chop
      if body.size + url.size + 1 > 140
        body_len = 140 - url.size + 1 + 3
        body = body[0..body_len] + '...'
      end
      tweet = "#{body} #{url}"
      tw = Twitter::Client.new
      tw.update(tweet)
    rescue => e
    end
  end
end

