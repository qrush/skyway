module Skyway
  def self.admin_password
    if Rails.env.development? || Rails.env.test?
      "deadbeef"
    else
      ENV['ADMIN_PASSWORD']
    end
  end
end
