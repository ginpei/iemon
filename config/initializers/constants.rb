if Rails.env.production?
  DEFAULT_PROVIDER = "twitter"
else
  #DEFAULT_PROVIDER = "developer"
  DEFAULT_PROVIDER = "twitter"
end
