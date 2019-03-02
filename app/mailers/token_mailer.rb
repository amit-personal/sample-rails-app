class TokenMailer < ActionMailer::Base
  layout false
  default from: "from@example.com"

  def reset_password(email, token)
    @email = email
    @token_url = "#{ENV['URL_SCHEME']}://#{ENV['URL_HOST']}/users/password/edit?reset_password_token=#{token}"
    mail to: email
  end
end
