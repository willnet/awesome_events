Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 
    Rails.application.secrets.twitter_api_key,
    Rails.application.secrets.twitter_api_secret
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

OmniAuth.config.logger = Rails.logger
