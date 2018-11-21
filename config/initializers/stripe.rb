require 'stripe'

#runs right before the server starts 
Rails.configuration.stripe = {
  :publishable_key => ENV['pk_test_arfOPOQqpluRgLpNXkTjQEOi
'],
  :secret_key      => ENV['sk_test_slVW1jhykkGdOu8tewqNEYG1
']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]