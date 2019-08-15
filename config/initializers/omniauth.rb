Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET_KEY']
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_API_SECRET_KEY']
end