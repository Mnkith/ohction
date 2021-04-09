Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end 

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google, ENV['google_KEY'], ENV['google_SECRET']
end 