namespace :sape do

  desc "Fetch links from server"
  task fetch: :environment do
    begin
      config = YAML.load_file('config/sape.yml') 
    rescue Errno::ENOENT
      fail "Config file not found (config/sape.yml)"
    end

    data          = Fetcher.get_data(config, 'simple')
    data_context  = Fetcher.get_data(config, 'context')
    configs, config_data = {}, {}

    pages         = data['__sape_links__']
    pages_context = data_context['__sape_links__']
    bot_ips       = data['__sape_ips__']

    %W{sape_delimiter sape_show_only_block sape_page_obligatory_output sape_new_url}.each do |item|
      config_data[item] = data["__#{item}__"]
    end

    Fetcher.fetch_config(config_data, bot_ips)    if pages.any?
    Fetcher.fetch_pages(pages, 'simple', true)          if pages.any?
    Fetcher.fetch_pages(pages_context, 'context') if pages_context.any?

  end
end