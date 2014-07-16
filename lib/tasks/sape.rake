require 'nokogiri'
require 'open-uri'

namespace :sape do
  def say text
    if Rails.env.development?
      puts text
    end
  end

  desc "Fetch links from server"
  task fetch: :environment do
    begin
      config = YAML.load_file('config/sape.yml') 
    rescue Errno::ENOENT
      fail "Config file not found (config/sape.yml)"
    end
    
    sape_user = config['sape_user']
    host      = config['host'].downcase
    charset   = config['charset'].upcase  || 'UTF-8'
    server    = config['server']          || 'dispenser-01.sape.ru'
    

    url = "http://#{server}/code.php?user=#{sape_user}&host=#{host}&format=json"

    begin
      data = open(url)
    rescue OpenURI::HTTPError
      fail "Could not receive data"
    end

    data = JSON.parse(data.read)

    configs = {}
    
    bot_ips = data['__sape_ips__']
    pages   = data['__sape_links__']

    if pages.any?
      SapeConfig.delete_all
      SapeLink.delete_all

      say "Ips:"
      bot_ips.each do |ip|
        SapeConfig.create name: 'ip', value: ip.text
        say "Added #{ip.text}"
      end

      say "Config"
      %W{sape_delimiter sape_show_only_block ape_page_obligatory_output sape_block_tpl}.each do |item|
        SapeConfig.create name: item, value: data["__#{item}__"]
        say "Added #{item} = #{data["__#{item}__"]}"
      end

      say "Links"
      pages.each do |url, links|
        say "Page: #{page['url']}"
        links.each do |item|
          item = Nokogiri::HTML(q)
          # NEED TO PARSE!!!! + NEED TO ADD RAW LINKS(FOR NOT BLOCK LINKS)
          # anchor = item.at_xpath('anchor').text
          # text   = item.text
          # url    = item.at_xpath('url').text
          SapeLink.create page: page['url'], anchor: anchor, text: text, url: url
          say "   Added #{anchor} #{text} #{url}"
        end
      end
    end
  end
end