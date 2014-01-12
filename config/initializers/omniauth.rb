Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'CWUih1lMjsh4Itzflq5yKg', 'xz0HNek2VvvodgBcjxz9mcGewQAUB9GX9fToBRrg'
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
