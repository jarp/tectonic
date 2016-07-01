Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["TECTONIC_CLIENT_ID"], ENV["TECTONIC_CLIENT_SECRET"],{
    :name => 'google',
    :scope => ['userinfo.email', 'userinfo.profile']
  }
end
