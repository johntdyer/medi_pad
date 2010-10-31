Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, 'hnZ3wnxVY4X2RMOA9k37Q', 'KyXDCpqVrNJ5m7kuWWe4PkwkDjTZtUjtaqiPbUM8WAw'  
#  provider :facebook, 'APP_ID', 'APP_SECRET'  
#  provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'  
end

=begin

@Anywhere Settings
@Anywhere is easy to deploy. You only need an API key and registered callback URL.
API key
hnZ3wnxVY4X2RMOA9k37Q
Registered Callback URL

The @Anywhere callback URL's domain & subdomain must match the location of @Anywhere integrations on your site. 
You can authorize additional domains if you need to integrate with more than one site.
OAuth 1.0a Settings
OAuth 1.0a integrations require more work.
Consumer key
hnZ3wnxVY4X2RMOA9k37Q
Consumer secret
KyXDCpqVrNJ5m7kuWWe4PkwkDjTZtUjtaqiPbUM8WAw
Request token URL
https://api.twitter.com/oauth/request_token
Access token URL
https://api.twitter.com/oauth/access_token
Authorize URL
https://api.twitter.com/oauth/authorize
We support hmac-sha1 signatures. We do not support the plaintext signature method.

=end