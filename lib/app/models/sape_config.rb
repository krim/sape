class SapeConfig < ActiveRecord::Base
  class << self
    def bot_ips(site_host)
      where(name: 'ip', site_host: site_host).pluck(:value)
    end

    def check_code(site_host)
      where(name: 'sape_new_url', site_host: site_host).first.try(:value) || " "
    end

    def delimiter(site_host)
      where(name: 'sape_delimiter', site_host: site_host).first.try(:value) || " "
    end
  end
end