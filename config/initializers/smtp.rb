ActionMailer::Base.smtp_settings = {
  domain: 'YOUR_DOMAIN.COM',
  address:        "smtp.sendgrid.net",
  port:            465,
  authentication: :plain,
  user_name:      'apikey',
  password:       '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'
}