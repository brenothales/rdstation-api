Devise.setup do |config|
  # The e-mail address that mail will appear to be sent from
  # If absent, mail is sent from "please-change-me-at-config-initializers-devise@example.com"
  config.mailer_sender = "support@myapp.com"

  # If using rails-api, you may want to tell devise to not use ActionDispatch::Flash
  # middleware b/c rails-api does not include it.
  # See: http://stackoverflow.com/q/19600905/806956
  config.navigational_formats = [:json]
  config.secret_key = 'edcc61dc332b125a3b6991a963fa82fd2a14941423ad8eb63e6578c6b736d75262cf4ea7e4c56d040d15ed810047d2cefb109d704c7303bc74c042feafd23b9c'
end
