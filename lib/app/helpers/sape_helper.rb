require 'domainatrix'

module SapeHelper
  def sape_links
    options = { links: SapeLink.where(page: request.original_fullpath) }
    if SapeConfig.bot_ips.include?(request.remote_addr)
      options.merge!(start: SapeConfig.start_code)
      options.merge!(stop:  SapeConfig.stop_code)
    end
    render template: 'sape/links', locals: options
  rescue Exception => e
    "<!-- ERROR: #{e.message} -->".html_safe
  end
end