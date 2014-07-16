module SapeHelper
  def sape_links_block
    options = { links: SapeLink.where(page: request.original_fullpath, link_type: "simple") }
    if SapeConfig.bot_ips.include?(request.remote_addr)
      options.merge!(check_code: SapeConfig.check_code)
    end

    render template: 'sape/links', locals: options
  rescue Exception => e
    "<!-- ERROR: #{e.message} -->".html_safe
  end

  def sape_links
    SapeLink.where(page: request.original_fullpath, link_type: "simple").
             pluck(:raw_link).
             join(SapeConfig.delimiter)
  rescue Exception => e
    "<!-- ERROR: #{e.message} -->".html_safe
  end

  def sape_context_links(text)
    SapeLink.where(page: request.original_fullpath, link_type: "context").each do |link|
      text.gsub!(link.anchor, link.raw_link)
    end

    if SapeConfig.bot_ips.include?(request.remote_addr)
      "<sape_index>" + text + "</sape_index>" + SapeConfig.check_code
    else
      text
    end
  rescue Exception => e
    "<!-- ERROR: #{e.message} -->".html_safe
  end
end