class SapeConfig < ActiveRecord::Base
  class << self
    def bot_ips
      where(name: 'ip').pluck(:value)
    end

    def check_code
      where(name: 'sape_new_url').first.try(:value) || " "
    end

    def delimiter
      where(name: 'sape_delimiter').first.try(:value) || " "
    end
  end
end