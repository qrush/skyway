Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    '11k3425sZHs3rLahHqNBRUTYDKcQasm9',
    ENV['AUTH0_KEY'],
    'aqueous.auth0.com',
    callback_path: "/auth/auth0/callback"
  )
end
