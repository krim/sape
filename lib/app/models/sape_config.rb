class SapeConfig < ActiveRecord::Base
  class << self
    def bot_ips
      where(name: 'ip', site_host: request.host).pluck(:value)
    end

    def check_code
      where(name: 'sape_new_url', site_host: request.host).first.try(:value) || " "
    end

    def delimiter
      where(name: 'sape_delimiter', site_host: request.host).first.try(:value) || " "
    end
  end
end