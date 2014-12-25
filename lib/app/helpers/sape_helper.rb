module SapeHelper
  def sape_links_block(site_host = request.host)
    request.original_fullpath.chomp!("/") if request.original_fullpath.last == "/" && request.original_fullpath != '/'
    options = { links: SapeLink.where(page: request.original_fullpath, link_type: "simple", site_host: site_host) }
    if SapeConfig.bot_ips(site_host).include?(request.remote_addr)
      options.merge!(check_code: SapeConfig.check_code(site_host))
    end

    render template: 'sape/links', locals: options
  rescue Exception => e
    "<!-- ERROR: #{e.message} -->".html_safe
  end

  def sape_links(site_host = request.host)
    request.original_fullpath.chomp!("/") if request.original_fullpath.last == "/" && request.original_fullpath != '/'
    links = SapeLink.where(page: request.original_fullpath, link_type: "simple", site_host: site_host).
             pluck(:raw_link).
             join(SapeConfig.delimiter(site_host))

    (SapeConfig.bot_ips(site_host).include?(request.remote_addr) ? (links + SapeConfig.check_code(site_host)) : links).html_safe
  rescue Exception => e
    "<!-- ERROR: #{e.message} -->".html_safe
  end

  def sape_context_links(text, site_host = request.host)
    request.original_fullpath.chomp!("/") if request.original_fullpath.last == "/" && request.original_fullpath != '/'
    SapeLink.where(page: request.original_fullpath, link_type: "context", site_host: site_host).each do |link|
      text.sub!(link.anchor, link.raw_link)
    end

    if SapeConfig.bot_ips(site_host).include?(request.remote_addr)
      "<sape_index>" + text + "</sape_index>" + SapeConfig.check_code(site_host)
    else
      text
    end.html_safe
  rescue Exception => e
    "<!-- ERROR: #{e.message} -->".html_safe
  end
end