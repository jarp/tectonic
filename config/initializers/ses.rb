if Rails.env.production?
end
  ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
    access_key_id: "#{ENV['WN_AWS_ID']}",
    secret_access_key: "#{ENV['WN_AWS_KEY']}"
