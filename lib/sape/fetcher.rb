require 'nokogiri'
require 'open-uri'
require 'domainatrix'

class Fetcher
  class << self

    def say text
      puts text if Rails.env.development?
    end

    def get_data(config, link_type, site_host)

      sape_user  = config['sape_user']
      charset    = config['charset']       || 'utf-8'
      server     = config['server']        || 'dispenser-01.sape.ru'
      links_type = {'simple' => 'code.php', 'context' => 'code_context.php'}

      url = "http://#{server}/#{links_type[link_type]}?user=#{sape_user}&host=#{site_host}&format=json&no_slash_fix=true"

      begin
        data = open(url)
      rescue OpenURI::HTTPError
        fail "Could not receive data"
      end

      JSON.parse(data.read)
    end

    def fetch_pages(pages, link_type, delete_old = false, site_host)
      SapeLink.where(site_host: site_host).delete_all if delete_old
      say "Links:: #{link_type}"
      pages.each do |page_url, links|
        say "Page: #{page_url}"
        links.each do |link|
          item = Nokogiri::HTML.parse(link)

          anchor    = item.css('a').text
          url       = item.css('a').attr('href').text
          url_host  = Domainatrix.parse(url).host
          SapeLink.create site_host: site_host, page: page_url, anchor: anchor, host: url_host, raw_link: link, url: url, link_type: link_type
          say "   Added #{site_host} :: #{anchor} #{url_host} #{url}"
        end
      end
    end

    def fetch_config(config_data, bot_ips, site_host)
      SapeConfig.where(site_host: site_host).delete_all
      say "Ips:"
      bot_ips.each do |ip|
        SapeConfig.create name: 'ip', value: ip
        say "   Added #{ip}"
      end
      say "Config"
      config_data.each do |item, data|
        SapeConfig.create site_host: site_host, name: item, value: data
        say "   Added #{item} = #{data}"
      end
    end

  end
end