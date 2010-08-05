# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_medi_pad_session',
  :secret      => '18f2014de52a42ba4ee35da3ecf94616df20efa06bbc72d7b2c8faa91c16b3b86edb1eb86251cff4aa64118974e82b90d23f94176bb56802504d35e32fbd51dc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
