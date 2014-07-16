require 'nokogiri'
require 'open-uri'

class Fetcher
  class << self

    def say text
      puts text if Rails.env.development?
    end

    def get_data(config, link_type)

      sape_user  = config['sape_user']
      host       = config['host'].downcase
      charset    = config['charset']       || 'utf-8'
      server     = config['server']        || 'dispenser-01.sape.ru'
      links_type = {'simple' => 'code.php', 'context' => 'code_context.php'}

      url = "http://#{server}/#{links_type[link_type]}?user=#{sape_user}&host=#{host}&format=json&no_slash_fix=true"

      begin
        data = open(url)
      rescue OpenURI::HTTPError
        fail "Could not receive data"
      end

      JSON.parse(data.read)
    end

    def fetch_pages(pages, link_type)
      SapeLink.delete_all
      say "Links:: #{link_type}"
      pages.each do |page_url, links|
        say "Page: #{page_url}"
        links.each do |link|
          item = Nokogiri::HTML.parse(link)

          anchor    = item.css('a').text
          url       = item.css('a').attr('href').text
          host      = Domainatrix.parse(url).host
          SapeLink.create page: page_url, anchor: anchor, host: host, raw_link: link, url: url, link_type: link_type
          say "   Added #{anchor} #{host} #{url}"
        end
      end
    end

    def fetch_config(config_data, bot_ips)
      SapeConfig.delete_all
      say "Ips:"
      bot_ips.each do |ip|
        SapeConfig.create name: 'ip', value: ip
        say "   Added #{ip}"
      end
      say "Config"
      config_data.each do |item, data|
        SapeConfig.create name: item, value: data
        say "   Added #{item} = #{data}"
      end
    end

  end
end